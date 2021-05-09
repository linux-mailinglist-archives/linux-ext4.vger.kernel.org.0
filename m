Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E25377713
	for <lists+linux-ext4@lfdr.de>; Sun,  9 May 2021 16:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhEIOsk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 May 2021 10:48:40 -0400
Received: from sonic303-24.consmr.mail.gq1.yahoo.com ([98.137.64.205]:34194
        "EHLO sonic303-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229631AbhEIOsg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 May 2021 10:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1620571653; bh=DD6INhDAYtOvTP5v/+rsKZCm6Op/XIxo1DTgPoGYrgE=; h=Date:From:Subject:To:References:In-Reply-To:From:Subject:Reply-To; b=n+UKMaHQg8CfiniV8jyI0iVdktLykWjDi9tO+o7db08NQx4D9pr09OkFFuNt/11v6sbm4CL6JwNj8SEHT3S5m6THcuJ/2nT+RyK2finVzHGQh8SwMvmDznXGgR4nLIq97jka2B2/f6/Mg7cGqw8RVhGqDFJX/bDwGE5O3SVOU2BO7PGsWIXZBld5V9pf8tH8Kn2mFOdBbMpHdSJAKBYntVY5AjIQp2ttU+YejHyENMh6GIQWo7YS//8P1Zu0TOo1Moe7402aRaPtlCqYcxoDbsCfeaB48AsrVn+2UDk4kxc34JBmXBlTA363Gu7Jl3Ip7Iqb/KMZSVXd8A/K37XqBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620571653; bh=Nn2uw4WgyvmGC6WU9ERH4IdjkgwnqbJa6ewsffYOv/3=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=XEhpRhGFRW5kSIGdPt6IpYHhFOFHUZ4lrYSkOHHh+WNa3aCA9m7os/9oVij+Tyb2qh5RekFseEVodBJh+e/4ZsBcF+JtAJ8549SL/SWOBRrZJok66gUWueia1ervBdsU981ptimQYSzQA6g8ZIJCUyYWdFc6DL0RSzV0veUjt2wOEEjX+TbbeQYmMJmSz/kjFCdWwFJU0I+LzUX/kdyFAYBJWbSxca7xPfZUSNoaHXY9wJPhXzUXoeGQw1Tcb/yBeW6mGfQYQXoqWNOnckbjNR0P+DWlHqg3TRDwT6Izq7YMwFixPzXhpKA9AzQGbhUdLGTjR4+dHRayb+GrKC/ISg==
X-YMail-OSG: 44C1mF0VM1ku0.ynoWc_vjCvHNB2yfcDeKz8.mHHN4Z2E7pgWGtk2x7.5Egh8cH
 8Ddts59WhEkjZZOl88FSBErZ5_eFtESnxAk5LKYU_rnxHKVym7.P7Hjyte9B2uJ.gJRcVU9qYQZO
 5ABtGnl3yCCPE0k97vK8fP5L.sNArVh8162LrfFTr6XKUkz0DmoSsXBKV7hok4Jj7J0SPOf0Eaa1
 IASMJJgfUMaIiyt2nSgWdwfr9Pzkc1LWO5jQabrOIIhFkZ2_BNURMTrM5h5IBCobeZLUVjMSVlP3
 OQ0QPa1A17UYi9C5SKGOsdWpON1T8D2T7NjeBqHx.QNFMub3YKI4YB2YSUrHkRXLx_EzZ5NbSp0P
 ICsmqaQKNiGPYOGm5tNlQNYtDIlmYDPdm6_zcuAPHlumYb2FFL.NreSzrYJKGvX1JnQmQJY.X6CJ
 Lb2Fmjhd3weq6fks5WOaLXtAVkAxNRF6zTyU12TWuoI3CGUjarfYqW2mEBf8cI8km33bVMN3G_.4
 pNw_jaLQIMDfdV0V6PwfCqPxD_gyLic6KS8HOxgG87vIxZLG2qfxcLX0c6LM_8enTYZPGIrHxNT.
 O_azxSToCefmqF_Y5ilQSGmTFZfZz1Lpsz9dO_NtwtanT_2ukL994C_YjqyPsfoWtKDYKzsLvPtP
 .OD_IgADPzIg.dug8BXLpWRzX8oWyScvbud5dK_YD2iDmhaYC4MH6r9NQ6LZpuDhUIkuFKS1MwSq
 Z_1bYpydEzcN_CPIMTqsbEmufPMFqu0GWuxxijeqTj.RLKxqC4DZWuIWuqYbqVwkGNsazi89nd6C
 WmPdaUFcPq_g.KWRUimlrqA33d8GGSsd7SMt0JHTRIwgtQnMozYve1dvuFnlKTeC2fvhoaCOU0Sd
 ByCpzal9_SD1id7kph2cyTAYLNwDuzFHng64PIIj4qL4r9jtGVM8hhtiRfHHbUTLlyYvPmeW62cs
 .kHFRZCcSjDghLZUTyLW00t0GscrSEfbDK80SFUzdj_tIJqBJuvVJVgXKjDB36seH8llGZn..TBC
 rd26jLFOiAZLNBncuxR0cP4XJcqP0Sj7MCJhQnBPKQNjBvtXmBMchEmvUW9LACxv3t3tmpl1qgoZ
 2eU.CaMW9yusOF9Kba4opO8YFj4LT0CGjvcReTbeK0UJxAw9tT9U4_CZp2UCAzL_BSyJ_5ClqEOY
 ISfZIdu6Xgrc.AcNrGcBg5nKRkRNZ0QQ_V72goPiYl_RkHMyi0h4Y9SZHBRVLUn9uegNF_uywHvD
 lIbsjrTqFQ6a.SceKtYtQ8P3d22MSIZUQcZnrD3OQtSj82g55tqebw3RBBz.h3eAF7YpTlHR8nCp
 Df.6I3QKyXIAoWb7j_8TY8W8gFdKsjBYllN_ErB6CwZAnB6Cx5Fz4Iq0eIYpsbBew6pTgEEbKBEv
 Obtt6_hlICkLFmdRgdKPLQmqX1PuD1fg.Q6BlAIil15Nd1DVXS18R.tJxslxEQD4U_aK_pfrkkAZ
 3Xwtor1s6O62rMifYJf0BRG7uFv.yRPoQwv56Oac1jHF7CmByCOP3O9O1Zrt.aztSNbdyEDFYMr6
 WOXcei_KN6GPDXuM58C0F.ph8nd9_8i64Zlhit2J5t28vr97isz3gVnCXkUhGmrpcNxzTKtAcc3q
 QJsfbD1HcApim2N3TeaFkG3q.7XvPGjLCeMH_sCOzNkAHliEBwM5Yn5HepPpq00sGE98iKQSD4rh
 m5qN76ToFwPHSb86hzMmHTiMp5EVUNwRGL4ZnHsITggMjDvw1Gmmfrsa8qcpg88tPCDKflbs6CIj
 OS9WtusQglvrR3DDJNX9KWsykdd0eXuZgd9q3yXWc_bPgmIXzNOJzNIq0W8mRMj0ZdrRO.GTvDbz
 j2s7ptIstvIMa6KA8N_vKzY8nOK6nqR4UWxykBjTJiu4LiCAEJpITVYCwLL5jQwYHEvH6RMNtq2u
 cbzQ10Auz.j62v9RQNZA.WBaQCytUF_jxftXF3tcARrvsGOplngpVG6xstAlv4WDyGhabFU1w._D
 USSZxS7iN2g0MO7EqD3eVNB51w.X67sGDD4h4qk8Nl1xTLY3Hrcj3Oo13T4q9Gx6CscztsGqOuvl
 xLhJCmnz1ZkUqXpUwkg1qQXNGy82fUUQqNcM7BLffkDGW7set.8Kpa30BuFhTdrdPkzG4Kfm419K
 ebjBqx33TqFjYrAekuGtmFTCBryyAQRggDBGKep7HCz.jP3VfP1rq7TH3KsHZtpEJVnqn40THi1C
 n0NtgzFaVLC7XNdShlJqLWKXg6bA59sSVBKvmeGLj9Yz_69TmpgczKohls1jlZWV1aJmE85lfkDn
 MWR1mbzSJcd5dXZ9zMljtZNUdtMWgxgXl2CYhN8aT_Nx70P0bpFDrOqbI9LncNT1i9lX6RolIeoH
 JuMKlfukOo8W9INDDxXrArKQ.9SawMSlXr9JS8Sicd3FiNpkUiXCTb8Vw.qd_0pKujkpy1PGGUA.
 SpfF4d5GoAyoMYqqCABfXiSxH5y2LLmi0Qd6q4miMNS.Rm0hEl7yhX1Kt3cVtm9EMvrSoX0_t6Cv
 D9CCIuHRJn92G_gRl0rxMiK3LqyVj42ts7kO4C6bPt4WDRNNhPu9n_1nuoJoQCDywA4T7PBhiWD9
 V7xWsX100KXBlZoWLVz9s2iQSgF4gSHfeO4UTdJIIwCYBpLWc1wBQVgKerC0VQHARf0y9SEG53GH
 Hb_FJ_x3V4Oh716DGdTXIRBElJ36mtPonLxMl1dJWONsXthIC7Qn.71QM.f.zS1jDwiQMHbrwRwm
 UMA207I.Dtkv8bKZPPrMuiVSMo.of0nOCWpVhV41.sbN4aG4glYj7AjvnnI1aCanSHCVm1S9eeKc
 b1uTf35PL.aFeJSd92UD9Jc9vI8usQtiL3LEFe6EG
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sun, 9 May 2021 14:47:33 +0000
Received: by kubenode508.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 22743aee1a424fd368a0fbe95bdd2365;
          Sun, 09 May 2021 14:47:29 +0000 (UTC)
Date:   Sun, 09 May 2021 10:47:26 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
To:     Jens Axboe <axboe@kernel.dk>, bgoncalv@redhat.com,
        bvanassche@acm.org, dm-crypt@saout.de, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, ming.lei@redhat.com,
        Changheun Lee <nanich.lee@samsung.com>, yi.zhang@redhat.com
References: <1620493841.bxdq8r5haw.none@localhost>
        <1620526887.tg1zx7w5np.none@localhost>
        <f0c90fc0-c239-df68-371d-a5c74c8f32eb@kernel.dk>
In-Reply-To: <f0c90fc0-c239-df68-371d-a5c74c8f32eb@kernel.dk>
MIME-Version: 1.0
Message-Id: <1620571445.2k94orj8ee.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.18231 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Excerpts from Jens Axboe's message of May 8, 2021 11:51 pm:
> On 5/8/21 8:29 PM, Alex Xu (Hello71) wrote:
>> Excerpts from Alex Xu (Hello71)'s message of May 8, 2021 1:54 pm:
>>> Hi all,
>>>
>>> Using torvalds master, I recently encountered data corruption on my ext=
4=20
>>> volume on LUKS on NVMe. Specifically, during heavy writes, the system=20
>>> partially hangs; SysRq-W shows that processes are blocked in the kernel=
=20
>>> on I/O. After forcibly rebooting, chunks of files are replaced with=20
>>> other, unrelated data. I'm not sure exactly what the data is; some of i=
t=20
>>> is unknown binary data, but in at least one case, a list of file paths=20
>>> was inserted into a file, indicating that the data is misdirected after=
=20
>>> encryption.
>>>
>>> This issue appears to affect files receiving writes in the temporal=20
>>> vicinity of the hang, but affects both new and old data: for example, m=
y=20
>>> shell history file was corrupted up to many months before.
>>>
>>> The drive reports no SMART issues.
>>>
>>> I believe this is a regression in the kernel related to something merge=
d=20
>>> in the last few days, as it consistently occurs with my most recent=20
>>> kernel versions, but disappears when reverting to an older kernel.
>>>
>>> I haven't investigated further, such as by bisecting. I hope this is=20
>>> sufficient information to give someone a lead on the issue, and if it i=
s=20
>>> a bug, nail it down before anybody else loses data.
>>>
>>> Regards,
>>> Alex.
>>>
>>=20
>> I found the following test to reproduce a hang, which I guess may be the=
=20
>> cause:
>>=20
>> host$ cd /tmp
>> host$ truncate -s 10G drive
>> host$ qemu-system-x86_64 -drive format=3Draw,file=3Ddrive,if=3Dnone,id=
=3Ddrive -device nvme,drive=3Ddrive,serial=3D1 [... more VM setup options]
>> guest$ cryptsetup luksFormat /dev/nvme0n1
>> [accept warning, use any password]
>> guest$ cryptsetup open /dev/nvme0n1
>> [enter password]
>> guest$ mkfs.ext4 /dev/mapper/test
>> [normal output...]
>> Creating journal (16384 blocks): [hangs forever]
>>=20
>> I bisected this issue to:
>>=20
>> cd2c7545ae1beac3b6aae033c7f31193b3255946 is the first bad commit
>> commit cd2c7545ae1beac3b6aae033c7f31193b3255946
>> Author: Changheun Lee <nanich.lee@samsung.com>
>> Date:   Mon May 3 18:52:03 2021 +0900
>>=20
>>     bio: limit bio max size
>>=20
>> I didn't try reverting this commit or further reducing the test case.=20
>> Let me know if you need my kernel config or other information.
>=20
> If you have time, please do test with that reverted. I'd be anxious to
> get this revert queued up for 5.13-rc1.
>=20
> --=20
> Jens Axboe
>=20
>=20

I tested reverting it on top of b741596468b010af2846b75f5e75a842ce344a6e=20
("Merge tag 'riscv-for-linus-5.13-mw1' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux"), causing it=20
to no longer hang. I didn't check if this fixes the data corruption, but=20
I assume so.

I also tested a 1 GB image (works either way), and a virtio-blk=20
interface (works either way)

The Show Blocked State from the VM (without revert):

sysrq: Show Blocked State
task:kworker/u2:0    state:D stack:    0 pid:    7 ppid:     2 flags:0x0000=
4000
Workqueue: kcryptd/252:0 kcryptd_crypt
Call Trace:
 __schedule+0x1a2/0x4f0
 schedule+0x63/0xe0
 schedule_timeout+0x6a/0xd0
 ? lock_timer_base+0x80/0x80
 io_schedule_timeout+0x4c/0x70
 mempool_alloc+0xfc/0x130
 ? __wake_up_common_lock+0x90/0x90
 kcryptd_crypt+0x291/0x4e0
 process_one_work+0x1b1/0x300
 worker_thread+0x48/0x3d0
 ? process_one_work+0x300/0x300
 kthread+0x129/0x150
 ? __kthread_create_worker+0x100/0x100
 ret_from_fork+0x22/0x30
task:mkfs.ext4       state:D stack:    0 pid:  979 ppid:   964 flags:0x0000=
4000
Call Trace:
 __schedule+0x1a2/0x4f0
 ? __schedule+0x1aa/0x4f0
 schedule+0x63/0xe0
 schedule_timeout+0x99/0xd0
 io_schedule_timeout+0x4c/0x70
 wait_for_completion_io+0x74/0xc0
 submit_bio_wait+0x46/0x60
 blkdev_issue_zeroout+0x118/0x1f0
 blkdev_fallocate+0x125/0x180
 vfs_fallocate+0x126/0x2e0
 __x64_sys_fallocate+0x37/0x60
 do_syscall_64+0x61/0x80
 ? do_syscall_64+0x6e/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Regards,
Alex.
