use std::fs::read;

use clap::Clap;
use ignore::WalkBuilder;
use sha2::{Digest, Sha256};

#[derive(Clap)]
#[clap(version = "0.1")]
struct Opts {
    #[clap(short, long)]
    verbose: bool,

    #[clap(short = 'f', long, default_value = ".contenthashignore")]
    ignore_file: String,

    #[clap(default_value = ".")]
    context: String,
}

fn to_hex(buf: &[u8]) -> String {
    buf.iter()
        .map(|s| format!("{:01$x}", s, 2).to_lowercase())
        .collect::<String>()
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let opt: Opts = Opts::parse();

    let walker = WalkBuilder::new(opt.context)
        .add_custom_ignore_filename(opt.ignore_file)
        .hidden(false)
        .build();

    let mut hashes = vec![];

    for result in walker {
        let dir_entry = result?;

        if dir_entry.path().is_dir() {
            continue;
        }

        let content = read(dir_entry.path())?;
        let hash = Sha256::digest(content.as_slice());
        let hash_str = to_hex(hash.as_slice());

        if opt.verbose {
            println!(
                "{}  {}",
                hash_str,
                dir_entry.path().to_str().unwrap_or_else(|| ""),
            );
        }

        hashes.push(hash_str);
    }

    if hashes.is_empty() {
        return Ok(());
    }

    hashes.sort();

    let mut concatenated_hashes: String = hashes.join("\n");
    // Really to mimic the bash script's behavior so we can test against it
    concatenated_hashes.push('\n');

    let final_hash = Sha256::digest(concatenated_hashes.as_bytes());
    let final_hash_str = to_hex(final_hash.as_slice());

    println!("{}", final_hash_str);

    Ok(())
}
