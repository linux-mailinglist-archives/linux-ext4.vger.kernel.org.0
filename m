Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3764541A
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 07:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLGGjf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 01:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLGGje (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 01:39:34 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8CE7F;
        Tue,  6 Dec 2022 22:39:32 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NRnc01m43zJp3K;
        Wed,  7 Dec 2022 14:36:00 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 14:39:30 +0800
Subject: Re: [BUG REPORT] kernel BUG in ext4_write_inline_data_end or
 ext4_writepages
To:     Jun Nie <jun.nie@linaro.org>, <harshadshirwadkar@gmail.com>,
        <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ye Bin <yebin@huaweicloud.com>
References: <CABymUCOsVcpaS+uXqzB7-hm0FZwm2ZXD8J=6m0NKAh8WyrTiwA@mail.gmail.com>
 <CABymUCP32_95eTeEbfWCPEUBCj4XBMU5=2-hRBLw9SoTFt_6XQ@mail.gmail.com>
CC:     Lee Jones <joneslee@google.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <63903521.5040307@huawei.com>
Date:   Wed, 7 Dec 2022 14:39:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CABymUCP32_95eTeEbfWCPEUBCj4XBMU5=2-hRBLw9SoTFt_6XQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/12/5 16:54, Jun Nie wrote:
> Hi,
> syzbot find a new bug[1] in ext4 that's similar with bug[0], that
> leads to reboot.
> While the bug[0] can be fixed with patch[2] from Bin. This new bug is still
> triggered with the patch[2], and log[3] is collected. Both log[1] and
> log[3] are
> collected when testing bug[4] on the mainline.
>
> [0] https://syzkaller.appspot.com/bug?id=5bafe4554067100b70f58a81268aa06ea3f9c345
> [1] https://syzkaller.appspot.com/text?tag=CrashLog&x=16325fc3880000
> [2] https://lore.kernel.org/lkml/CABymUCN+NSzkunRqFs8LgqjT6vXz-gyyZYn0hQWf8V9kmcO0Hw@mail.gmail.com/T/
> [3] https://syzkaller.appspot.com/text?tag=CrashLog&x=155abe7b880000
> [4] https://syzkaller.appspot.com/bug?id=899b37f20ce4072bcdfecfe1647b39602e956e36
>
>
> [   38.932317][  T494] Call Trace:
> [   38.935437][  T494]  <TASK>
> [   38.938393][  T494]  ext4_write_inline_data_end+0xa39/0xdf0
> [   38.943946][  T494]  ? put_page+0xa0/0xa0
> [   38.947936][  T494]  ? ext4_da_write_begin+0x6f0/0x8d0
> [   38.953055][  T494]  ? pipe_zero+0x240/0x240
> [   38.957308][  T494]  ext4_da_write_end+0x1e2/0x950
> [   38.962082][  T494]  ? ext4_da_write_begin+0x8d0/0x8d0
> [   38.967204][  T494]  generic_perform_write+0x401/0x5f0
> [   38.972326][  T494]  ? generic_file_direct_write+0x6c0/0x6c0
> [   38.977994][  T494]  ? generic_write_checks_count+0x4b0/0x4b0
> [   38.983694][  T494]  ext4_buffered_write_iter+0x35f/0x640
> [   38.989074][  T494]  ext4_file_write_iter+0x198/0x1cd0
> [   38.994194][  T494]  ? futex_unqueue+0x156/0x180
> [   38.998795][  T494]  ? futex_wait+0x4c5/0x5c0
> [   39.003307][  T494]  ? futex_wait_setup+0x320/0x320
> [   39.008168][  T494]  ? avc_policy_seqno+0x1b/0x70
> [   39.012862][  T494]  ? ext4_file_read_iter+0x470/0x470
> [   39.017976][  T494]  vfs_write+0x8b5/0xef0
> [   39.022056][  T494]  ? file_end_write+0x1b0/0x1b0
> [   39.026739][  T494]  ? mutex_lock+0xb6/0x130
> [   39.030994][  T494]  ? bit_wait_io_timeout+0x110/0x110
> [   39.036117][  T494]  ? __fget_files+0x2d9/0x330
> [   39.040630][  T494]  ? __fdget_pos+0x268/0x300
> [   39.045054][  T494]  ? ksys_write+0x77/0x2c0
> [   39.049307][  T494]  ksys_write+0x198/0x2c0
> [   39.053472][  T494]  ? save_fpregs_to_fpstate+0x210/0x210
> [   39.058855][  T494]  ? __ia32_sys_read+0x90/0x90
> [   39.063465][  T494]  ? __kasan_check_write+0x14/0x20
> [   39.068403][  T494]  ? switch_fpu_return+0x129/0x270
> [   39.073348][  T494]  __x64_sys_write+0x7b/0x90
> [   39.077783][  T494]  do_syscall_64+0x2f/0x50
> [   39.082030][  T494]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Regards,
> Jun
> .

I analyze that the above issue should be caused by the concurrency
of inline data conversion and buffer write.
At present, I haven't thought of any good solution.


