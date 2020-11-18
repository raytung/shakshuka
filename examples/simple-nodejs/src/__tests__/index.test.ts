import { hello } from '../index';

describe("Index.ts", () => {
  it("says hello", () => {
    const result = hello("mini me");

    expect(result).toStrictEqual("Hello, mini me");
  });
});
