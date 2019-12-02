"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const responseCode_1 = require("../Enums/responseCode");
exports.hanlder = function (snapshot) {
    if (snapshot.after.data().codes.length == 0) {
        return snapshot.after.ref.delete();
    }
    else {
        return {
            status: responseCode_1.ResponseCode.SUCCESS,
            message: "This event still has codes available."
        };
    }
};
//# sourceMappingURL=cleanUpItems.js.map