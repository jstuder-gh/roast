use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 2;

is_run ｢
        use Test;
        plan 1;

        todo 1;
        ok 0;
        # subtest 'with plan' => {
        #     plan 5;
        #     ok 0;
        #     ok 1;
        #     ok 0;
        #
        #     todo 1;
        #     ok 0;
        #     ok 1;
        # }
    ｣, {
        :err(/Failed/),
        :out{ .contains('Failed').not and .comb('TODO') == 4 },
        :0status
    }, 'failing tests inside TODOed subtest with plan get reported as TODOs';

is_run ｢
        use Test;
        plan 1;

        todo 1;
        subtest 'without plan' => {
            ok 0;
            ok 1;
            ok 0;

            todo 1;
            ok 0;
            ok 1;
        }
    ｣, {
        :err(/Failed/),
        :out{ .contains('Failed').not and .comb('TODO') == 4 },
        :0status
    }, 'failing tests inside TODOed subtest without plan get reported as TODOs';
