Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CA2325BE3
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 04:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBZDX3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 22:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhBZDX2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Feb 2021 22:23:28 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C811C061574
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 19:22:48 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a24so4538157plm.11
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 19:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=c/HEc+Kcd4gSRF3+J0oyX3tI48hH3B5v9DYSMtPjhm0=;
        b=pvpcz6EGWclicwDMVMIPEIe6WffYgXwTBhCMG7dXK61UJHpMuEtUTAW5zGdYt1FVXb
         WUt6PG+xxi95Yy+cjSwBaAyuUh62L6Gub0Lj3AC1rekBgIKvGPKpNG5xd553kznMXedp
         38prPmCApTTj6bWHYsr7U5zPVrxpfQ2arvF0mlKlaj78O5+MFo2zbsqdkcEYGpxOpDoR
         ahIHN6HVPWyS4wYmYUesCVEIflThFX3ANSrHO8NAuOaDBszvcflgTjMFbiFMDZBeExX5
         SIBHDht66JTx+w7xI31EnJJuaYuT0Uv1xq8OrqGcbn3DrhWyxCmiKgAQXXKvw2Oi2RzT
         kY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=c/HEc+Kcd4gSRF3+J0oyX3tI48hH3B5v9DYSMtPjhm0=;
        b=cIgEAbCOUgauPohgJlUfn8g5rMfj0MEoNgl2NQdXy8DovyySWMn9H57xA4G8JjMhSN
         +PygLZPbnrAo7PN2XE8KsmhC0b+Ox/ph7HOL+oikwFfDwJF30oCFgatD7aJi7L3SjJ6q
         J8Osduicrzumt0b+vFRvaTuBPrvJ3ZCyAoS9lr4cGLIzvq1M3M6YBfjQ9e6VT1iaHE4a
         cbWiNCh6TW6eahG8PQDWWkJb6GxhD8M4p6n9ZuBYV9RHddMnNNx46FrsmKKrj48BNUmD
         91IjLCSHyaAeR7XYeWP2Jh7XRbDiWVXA4sT2wC9cIei/8dcRSsPQpJhn2AIw91OwTUXp
         AbEA==
X-Gm-Message-State: AOAM530cpjKHaGHRFge6fypp2jldZcKsIVQFxRFlI93qCWof3PWOlcn0
        UzaJYSan2f3cqF/pT2j68Xg/OQ==
X-Google-Smtp-Source: ABdhPJycbj7CVXAbrw9ZPhq81abGITZDGanGNWsDSg//QQoI+0eAEe0MxiLjNN7Z+VaVZIoYUprTDg==
X-Received: by 2002:a17:90a:1a13:: with SMTP id 19mr1203702pjk.159.1614309767502;
        Thu, 25 Feb 2021 19:22:47 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id ml17sm8562834pjb.45.2021.02.25.19.22.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 19:22:46 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7879534D-1CEB-42C6-A740-5D48EDAF9C63@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_848A5670-D03E-4EB9-B3CC-3C5A271502CA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [ext4]  ef4eebad9c:
 fxmark.hdd_ext4_no_jnl_MWCL_1_bufferedio.works/sec -9.8% regression
Date:   Thu, 25 Feb 2021 20:22:41 -0700
In-Reply-To: <20210214140921.GD6321@xsang-OptiPlex-9020>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        0day robot <lkp@intel.com>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>, Shuichi Ihara <sihara@ddn.com>
To:     kernel test robot <oliver.sang@intel.com>
References: <20210214140921.GD6321@xsang-OptiPlex-9020>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_848A5670-D03E-4EB9-B3CC-3C5A271502CA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Feb 14, 2021, at 7:09 AM, kernel test robot <oliver.sang@intel.com> =
wrote:
>=20
>=20
> Greeting,
>=20
> FYI, we noticed a -9.8% regression of =
fxmark.hdd_ext4_no_jnl_MWCL_1_bufferedio.works/sec due to commit:
>=20
>=20
> commit: ef4eebad9c018a972a470b7b41e68bc981b31d00 ("ext4: improve cr 0 =
/ cr 1 group scanning")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git =
Harshad-Shirwadkar/ext4-drop-s_mb_bal_lock-and-convert-protected-fields-to=
-atomic/20210210-054647

Hello Oliver and Intel team,
thanks for your regression report.  It is definitely very useful to have
such a service running against patches before they are landed.

I'd like to make a couple of suggestions on how these emails could be
more useful to the developers and others who see such reports.
- it would be good to positively identify the source of the patch.  In
  several parts of this email it references the git hash ef4eebad9c,
  but (AFAICS) this hash is only relevant in your local repository.
  While reviewing this result, we were not totally positive which
  version of the "ext4: improve cr 0 / cr 1 group scanning" patch was
  being tested, since there more than one version of this patch was
  sent to the list.  Including the original Message-Id from the email
  (I believe <20210209202857.4185846-5-harshadshirwadkar@gmail.com> in
  this case) would make it more obvious.
- the subject of the email is unrelated to the original patch, so it
  is more difficult to tie this report to the original patch, and it
  does not sort or thread together in the mail reader or archive.  I
  would recommend to make the subject match the original patch email
  "Re: [PATCH v2 4/5] ext4: improve cr 0 / cr 1 group scanning" and add
  "References: <20210209202857.4185846-5-harshadshirwadkar@gmail.com>"
  in the header so it threads together in the inbox and archives, and
  "fxmark.hdd_ext4_no_jnl_MWCL_1_bufferedio.works/sec -9.8% regression"
  as the first line in the body.
- while it is clear from the subject that there is a 9.8% regression
  in a test case, it isn't totally clear what this test case is, nor
  what is actually being measured (what is "works/sec", and does this
  patch add "doesn't work/sec"? :-).
- it would be useful to add a URL in every such email pointing to a
  general overview page like "So your patch got an email from the
  Intel Kernel Test Robot" that explains what this means (maybe with
  some nice stats showing how many patches Intel is testing, how many
  tests are run on the systems you have, and generally showing what a
  good job you are doing), along with a general explanation of how to
  interpret the results in the email.
- it would be even more useful to have a link to a specific page that
  explains what each test is doing (fxmark MWCL I guess) and what the
  specific regression is ("works/sec" doesn't really mean anything
  to me, and I have no idea what MWCL_1, _2, _36, _45 are).  Maybe
  this is already available somewhere, but having a link makes it much
  easier to find.
- the performance comparison itself is a bit confusing, as it isn't
  clear what "fail:runs" actually means.  It _looks_ like the "before"
  patch (a932b2b78) had as many test failures as the "after" patch,
  both "0 of 4" or "1 of 4" test runs, which doesn't explain the
  5%/10%/4%/9% reproduction%.
- the graphs at the end are (I guess) performance metrics vs. different
  commit hashes during git bisect to find the broken patch (?), but the
  x-axis isn't labelled, so it is hard to know.  There is a bit of a
  legend, showing "[*] bisect-good sample" and "[O] bisect-bad sample"
  but there are no '*' on the graphs, only 'O' and '+' so it is hard
  to know how to interpret them.

Thanks in any case for your work on this.  My email is only intended
to help us get the most value and understanding of the effort that
you and the many hard-working Xeon Phi cores are doing on our behalf.

Cheers, Andreas

> in testcase: fxmark
> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz =
with 80G memory
> with following parameters:
>=20
> 	disk: 1HDD
> 	media: hdd
> 	test: MWCL
> 	fstype: ext4_no_jnl
> 	directio: bufferedio
> 	cpufreq_governor: performance
> 	ucode: 0x11
>=20
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
>=20
> Details are as below:
> =
--------------------------------------------------------------------------=
------------------------>
>=20
>=20
> To reproduce:
>=20
>        git clone https://github.com/intel/lkp-tests.git
>        cd lkp-tests
>        bin/lkp install                job.yaml  # job file is attached =
in this email
>        bin/lkp split-job --compatible job.yaml
>        bin/lkp run                    compatible-job.yaml
>=20
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_g=
roup/test/testcase/ucode:
>  =
gcc-9/performance/bufferedio/1HDD/ext4_no_jnl/x86_64-rhel-8.3/hdd/debian-1=
0.4-x86_64-20200603.cgz/lkp-knm01/MWCL/fxmark/0x11
>=20
> commit:
>  a932b2b788 ("ext4: add MB_NUM_ORDERS macro")
>  ef4eebad9c ("ext4: improve cr 0 / cr 1 group scanning")
>=20
> a932b2b7885865bd ef4eebad9c018a972a470b7b41e
> ---------------- ---------------------------
>       fail:runs  %reproduction    fail:runs
>           |             |             |
>          0:4            5%           0:4     =
perf-profile.children.cycles-pp.error_return
>          1:4           10%           1:4     =
perf-profile.children.cycles-pp.error_entry
>           :4            4%           0:4     =
perf-profile.self.cycles-pp.error_return
>          1:4            9%           1:4     =
perf-profile.self.cycles-pp.error_entry
>         %stddev     %change         %stddev
>             \          |                \
>    315979            -9.8%     284922        =
fxmark.hdd_ext4_no_jnl_MWCL_1_bufferedio.works
>     10532            -9.8%       9497        =
fxmark.hdd_ext4_no_jnl_MWCL_1_bufferedio.works/sec
>      0.01 =C2=B1100%  +38150.0%       1.91 =C2=B1 11%  =
fxmark.hdd_ext4_no_jnl_MWCL_2_bufferedio.iowait_sec
>      0.01 =C2=B1100%  +38189.0%       3.16 =C2=B1 11%  =
fxmark.hdd_ext4_no_jnl_MWCL_2_bufferedio.iowait_util
>      5.33 =C2=B1 17%     +22.5%       6.52 =C2=B1  4%  =
fxmark.hdd_ext4_no_jnl_MWCL_36_bufferedio.idle_sec
>      0.49 =C2=B1 16%     +22.2%       0.60 =C2=B1  4%  =
fxmark.hdd_ext4_no_jnl_MWCL_36_bufferedio.idle_util
>      6.50 =C2=B1  9%     -21.6%       5.09 =C2=B1  8%  =
fxmark.hdd_ext4_no_jnl_MWCL_45_bufferedio.idle_sec
>      0.48 =C2=B1  9%     -22.6%       0.37 =C2=B1 10%  =
fxmark.hdd_ext4_no_jnl_MWCL_45_bufferedio.idle_util
>      0.00 =C2=B1173%  +75800.0%       1.90 =C2=B1 22%  =
fxmark.hdd_ext4_no_jnl_MWCL_4_bufferedio.iowait_sec
>      0.00 =C2=B1173%  +75915.1%       1.57 =C2=B1 22%  =
fxmark.hdd_ext4_no_jnl_MWCL_4_bufferedio.iowait_util
>      0.52 =C2=B1  6%     -11.1%       0.46 =C2=B1  4%  =
fxmark.hdd_ext4_no_jnl_MWCL_54_bufferedio.softirq_util
>      1090            +3.2%       1124        fxmark.time.elapsed_time
>      1090            +3.2%       1124        =
fxmark.time.elapsed_time.max
>     65107            -5.9%      61260        =
fxmark.time.involuntary_context_switches
>     69.50            -5.8%      65.50        =
fxmark.time.percent_of_cpu_this_job_got
>     28.28            -4.1%      27.11 =C2=B1  2%  =
fxmark.time.user_time
>      5.50 =C2=B1  3%      +2.8        8.26 =C2=B1  4%  =
mpstat.cpu.all.iowait%
>     58.50            -2.6%      57.00        vmstat.cpu.id
>     38021            -6.2%      35647        vmstat.io.bo
>     85553            -4.1%      82045        vmstat.system.in
>     58.98            -2.7%      57.37        iostat.cpu.idle
>      5.57 =C2=B1  4%     +49.8%       8.34 =C2=B1  4%  =
iostat.cpu.iowait
>     30.35            -3.1%      29.41        iostat.cpu.system
>      2.81            -5.3%       2.66        iostat.cpu.user
>    711278           +15.3%     820380        meminfo.Dirty
>   7003710            -9.0%    6376219        meminfo.KReclaimable
>      1840 =C2=B1 12%     +21.4%       2233        meminfo.Mlocked
>   7003710            -9.0%    6376219        meminfo.SReclaimable
>    710759           +15.4%     820265        numa-meminfo.node0.Dirty
>   6994361            -9.0%    6365487        =
numa-meminfo.node0.KReclaimable
>      1053 =C2=B1 12%     +21.6%       1281        =
numa-meminfo.node0.Mlocked
>   6994361            -9.0%    6365487        =
numa-meminfo.node0.SReclaimable
>    177664           +15.5%     205237        =
numa-vmstat.node0.nr_dirty
>    262.75 =C2=B1 12%     +21.9%     320.25        =
numa-vmstat.node0.nr_mlock
>   1751239            -9.0%    1594254        =
numa-vmstat.node0.nr_slab_reclaimable
>    178395           +15.4%     205952        =
numa-vmstat.node0.nr_zone_write_pending
>      2244 =C2=B1 68%     -82.7%     387.72 =C2=B1 15%  =
sched_debug.cfs_rq:/.load_avg.max
>    309.86 =C2=B1 59%     -72.6%      84.98 =C2=B1 14%  =
sched_debug.cfs_rq:/.load_avg.stddev
>    385204 =C2=B1  8%     -35.5%     248625 =C2=B1  6%  =
sched_debug.cfs_rq:/.min_vruntime.stddev
>   -681107           -51.9%    -327811        =
sched_debug.cfs_rq:/.spread0.min
>    385220 =C2=B1  8%     -35.5%     248625 =C2=B1  6%  =
sched_debug.cfs_rq:/.spread0.stddev
>     10.05 =C2=B1 51%    +506.0%      60.92 =C2=B1 32%  =
sched_debug.cfs_rq:/.util_est_enqueued.min
>    125.29 =C2=B1 14%     -18.5%     102.09 =C2=B1  7%  =
sched_debug.cfs_rq:/.util_est_enqueued.stddev
>     24.34 =C2=B1  8%     -21.6%      19.08 =C2=B1  2%  =
sched_debug.cpu.clock.stddev
>     61783 =C2=B1  8%     +33.0%      82157 =C2=B1  7%  =
sched_debug.cpu.nr_switches.avg
>     35702 =C2=B1  8%     +55.3%      55461 =C2=B1 11%  =
sched_debug.cpu.nr_switches.min
>      7989 =C2=B1 25%     +87.6%      14991 =C2=B1 24%  =
softirqs.CPU1.BLOCK
>    123512 =C2=B1  3%      -7.6%     114086 =C2=B1  2%  =
softirqs.CPU21.RCU
>    122473 =C2=B1  3%      -6.6%     114426 =C2=B1  2%  =
softirqs.CPU25.RCU
>     66489 =C2=B1  5%     -11.7%      58718 =C2=B1  5%  =
softirqs.CPU29.SCHED
>     99247 =C2=B1  3%      -8.6%      90723 =C2=B1  5%  =
softirqs.CPU33.RCU
>     56394 =C2=B1  3%     -13.5%      48805 =C2=B1  5%  =
softirqs.CPU36.SCHED
>     43799 =C2=B1  4%     -12.9%      38133 =C2=B1  4%  =
softirqs.CPU45.SCHED
>     44447 =C2=B1  4%     -12.0%      39128 =C2=B1  5%  =
softirqs.CPU51.SCHED
>    169512 =C2=B1  3%     -11.3%     150299 =C2=B1  3%  =
softirqs.CPU6.RCU
>     33198 =C2=B1  5%     -14.9%      28240 =C2=B1 11%  =
softirqs.CPU60.SCHED
>    147310 =C2=B1  6%      -9.0%     134107 =C2=B1  2%  =
softirqs.CPU9.RCU
>      0.04 =C2=B1  6%      -0.0        0.03 =C2=B1 14%  =
perf-stat.i.branch-miss-rate%
>    326874 =C2=B1  8%     -15.0%     277893 =C2=B1 12%  =
perf-stat.i.branch-misses
>     41754            -4.6%      39817        perf-stat.i.cpu-clock
>     85.39            -2.9%      82.87        =
perf-stat.i.cpu-migrations
>      0.38 =C2=B1 10%     -16.2%       0.32 =C2=B1 11%  =
perf-stat.i.instructions-per-iTLB-miss
>      0.00 =C2=B1 11%     -17.2%       0.00 =C2=B1 11%  perf-stat.i.ipc
>      1.06 =C2=B1  3%      -7.8%       0.98        =
perf-stat.i.major-faults
>      0.35            +4.1%       0.37        perf-stat.i.metric.K/sec
>     41754            -4.6%      39817        perf-stat.i.task-clock
>    348107 =C2=B1  7%     -14.8%     296451 =C2=B1 12%  =
perf-stat.ps.branch-misses
>     41967            -4.6%      40020        perf-stat.ps.cpu-clock
>     85.62            -2.9%      83.09        =
perf-stat.ps.cpu-migrations
>      1.05 =C2=B1  3%      -7.7%       0.97        =
perf-stat.ps.major-faults
>     41967            -4.6%      40020        perf-stat.ps.task-clock
>      0.11 =C2=B1  8%     -33.2%       0.07 =C2=B1 28%  =
perf-sched.sch_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_thro=
ttle
>      0.02 =C2=B1  9%    -100.0%       0.00        =
perf-sched.sch_delay.avg.ms.kthreadd.ret_from_fork
>      0.28 =C2=B1 83%     -86.7%       0.04 =C2=B1 33%  =
perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mempool_=
alloc.bio_alloc_bioset.submit_bh_wbc
>      0.01 =C2=B1 11%    -100.0%       0.00        =
perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.kthread.ret_from_for=
k
>      0.06 =C2=B1 19%     -28.4%       0.04 =C2=B1  8%  =
perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_fr=
om_fork
>      0.01 =C2=B1100%    +141.3%       0.03 =C2=B1  8%  =
perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__flush_w=
ork.lru_add_drain_all
>      0.06 =C2=B1 10%    -100.0%       0.00        =
perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion_killable.=
__kthread_create_on_node.kthread_create_on_node
>      0.35 =C2=B1113%     -79.7%       0.07 =C2=B1 40%  =
perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_e=
xit_group.do_syscall_64
>      2.77 =C2=B1 40%     -46.4%       1.49 =C2=B1 53%  =
perf-sched.sch_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_thro=
ttle
>      0.03 =C2=B1 21%    -100.0%       0.00        =
perf-sched.sch_delay.max.ms.kthreadd.ret_from_fork
>      0.01 =C2=B1 11%    -100.0%       0.00        =
perf-sched.sch_delay.max.ms.schedule_preempt_disabled.kthread.ret_from_for=
k
>      0.06 =C2=B1 13%    -100.0%       0.00        =
perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion_killable.=
__kthread_create_on_node.kthread_create_on_node
>    139.75 =C2=B1  7%     -13.4%     121.00 =C2=B1  3%  =
perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.shri=
nk_dentry_list.prune_dcache_sb.super_cache_scan
>      8210 =C2=B1 10%     -26.3%       6048 =C2=B1 12%  =
perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
>     88.37 =C2=B1 15%     -18.2%      72.31 =C2=B1 11%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mempool_=
alloc.bio_alloc_bioset.submit_bh_wbc
>     79.45 =C2=B1109%    +329.8%     341.45 =C2=B1 42%  =
perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lo=
ck.drm_gem_shmem_vunmap.mgag200_handle_damage
>    129.91 =C2=B1  2%     +52.5%     198.10 =C2=B1 48%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.submit_b=
io_checks.submit_bio_noacct.submit_bio
>    130.18 =C2=B1  3%     +72.5%     224.52 =C2=B1 51%  =
perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.write_ca=
che_pages.generic_writepages.do_writepages
>      8210 =C2=B1 10%     -26.3%       6048 =C2=B1 12%  =
perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
>    639.00            -4.1%     613.00        =
proc-vmstat.nr_active_anon
>    109230            -4.7%     104085        =
proc-vmstat.nr_active_file
>   9734223            -3.3%    9414937        proc-vmstat.nr_dirtied
>    178266           +15.5%     205864        proc-vmstat.nr_dirty
>    460.75 =C2=B1 12%     +21.4%     559.50        proc-vmstat.nr_mlock
>   1758100            -8.9%    1601542        =
proc-vmstat.nr_slab_reclaimable
>     68945            -3.0%      66853        =
proc-vmstat.nr_slab_unreclaimable
>   9734223            -3.3%    9414937        proc-vmstat.nr_written
>    639.00            -4.1%     613.00        =
proc-vmstat.nr_zone_active_anon
>    109230            -4.7%     104085        =
proc-vmstat.nr_zone_active_file
>    179007           +15.4%     206596        =
proc-vmstat.nr_zone_write_pending
>  24225927            -2.2%   23703313        proc-vmstat.numa_hit
>  24225924            -2.2%   23703311        proc-vmstat.numa_local
>  47793203            -3.0%   46353511        =
proc-vmstat.pgalloc_normal
>   4923908           +11.4%    5485129        proc-vmstat.pgdeactivate
>   3348086            +2.3%    3425886        proc-vmstat.pgfault
>  47786479            -3.0%   46346216        proc-vmstat.pgfree
>  41377300            -3.3%   40023642        proc-vmstat.pgpgout
>    264776            +2.5%     271513        proc-vmstat.pgreuse
>   4916073           +11.4%    5477332        proc-vmstat.pgrotated
> 1.779e+08            -2.8%  1.729e+08        proc-vmstat.slabs_scanned
>   9334464            +2.8%    9594624        =
proc-vmstat.unevictable_pgs_scanned
>    662.25 =C2=B1  8%     -15.7%     558.50 =C2=B1  6%  =
slabinfo.Acpi-Parse.active_objs
>   3972051            -9.0%    3616212        =
slabinfo.dentry.active_objs
>    189593            -8.9%     172660        =
slabinfo.dentry.active_slabs
>   3981471            -8.9%    3625865        slabinfo.dentry.num_objs
>    189593            -8.9%     172660        slabinfo.dentry.num_slabs
>      3665          +602.8%      25759        =
slabinfo.ext4_extent_status.active_objs
>     39.75          +558.5%     261.75        =
slabinfo.ext4_extent_status.active_slabs
>      4090          +554.0%      26752        =
slabinfo.ext4_extent_status.num_objs
>     39.75          +558.5%     261.75        =
slabinfo.ext4_extent_status.num_slabs
>      4203 =C2=B1  3%    -100.0%       0.00        =
slabinfo.ext4_groupinfo_4k.active_objs
>      4254 =C2=B1  2%    -100.0%       0.00        =
slabinfo.ext4_groupinfo_4k.num_objs
>   5178202            -9.1%    4707049        =
slabinfo.ext4_inode_cache.active_objs
>    191816            -9.1%     174364        =
slabinfo.ext4_inode_cache.active_slabs
>   5179060            -9.1%    4707847        =
slabinfo.ext4_inode_cache.num_objs
>    191816            -9.1%     174364        =
slabinfo.ext4_inode_cache.num_slabs
>      1133 =C2=B1  5%     -14.9%     965.00 =C2=B1 11%  =
slabinfo.kmalloc-rcl-96.num_objs
>     20676           +24.1%      25662        =
slabinfo.radix_tree_node.active_objs
>      1642           +14.8%       1885        =
slabinfo.radix_tree_node.active_slabs
>     23002           +14.8%      26403        =
slabinfo.radix_tree_node.num_objs
>      1642           +14.8%       1885        =
slabinfo.radix_tree_node.num_slabs
>      1069 =C2=B1  7%     +16.6%       1246 =C2=B1  6%  =
slabinfo.skbuff_fclone_cache.active_objs
>      1250 =C2=B1  5%     +15.8%       1448 =C2=B1  6%  =
slabinfo.skbuff_fclone_cache.num_objs
>      3019          +122.2%       6710        =
interrupts.CPU0.180:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
>     14733 =C2=B1 10%    +135.6%      34711 =C2=B1 39%  =
interrupts.CPU1.180:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
>     74.25 =C2=B1 41%    +328.6%     318.25 =C2=B1 54%  =
interrupts.CPU1.37:IR-PCI-MSI.4194305-edge.eth0-TxRx-0
>      4354 =C2=B1 25%     +29.9%       5655 =C2=B1 13%  =
interrupts.CPU11.CAL:Function_call_interrupts
>      1283           +25.2%       1607 =C2=B1 29%  =
interrupts.CPU127.CAL:Function_call_interrupts
>     10568 =C2=B1 28%     +34.3%      14193 =C2=B1 15%  =
interrupts.CPU2.CAL:Function_call_interrupts
>    985.00 =C2=B1 22%    +130.9%       2274 =C2=B1 42%  =
interrupts.CPU2.RES:Rescheduling_interrupts
>    263.25 =C2=B1  4%     +24.5%     327.75 =C2=B1 20%  =
interrupts.CPU2.TLB:TLB_shootdowns
>    312.00 =C2=B1 72%     -50.9%     153.25 =C2=B1 22%  =
interrupts.CPU20.NMI:Non-maskable_interrupts
>    312.00 =C2=B1 72%     -50.9%     153.25 =C2=B1 22%  =
interrupts.CPU20.PMI:Performance_monitoring_interrupts
>      4243 =C2=B1 10%     +45.5%       6172 =C2=B1  5%  =
interrupts.CPU22.CAL:Function_call_interrupts
>      3434 =C2=B1 20%     +58.2%       5433 =C2=B1 35%  =
interrupts.CPU25.CAL:Function_call_interrupts
>    491.25 =C2=B1 29%     -55.7%     217.75 =C2=B1 35%  =
interrupts.CPU27.NMI:Non-maskable_interrupts
>    491.25 =C2=B1 29%     -55.7%     217.75 =C2=B1 35%  =
interrupts.CPU27.PMI:Performance_monitoring_interrupts
>    390.50 =C2=B1 40%     -46.4%     209.50 =C2=B1  9%  =
interrupts.CPU29.RES:Rescheduling_interrupts
>    189.50 =C2=B1 11%     +23.9%     234.75 =C2=B1  5%  =
interrupts.CPU3.TLB:TLB_shootdowns
>    234.75 =C2=B1 32%     -39.8%     141.25 =C2=B1 29%  =
interrupts.CPU30.NMI:Non-maskable_interrupts
>    234.75 =C2=B1 32%     -39.8%     141.25 =C2=B1 29%  =
interrupts.CPU30.PMI:Performance_monitoring_interrupts
>    639.50 =C2=B1 65%     -53.0%     300.75 =C2=B1 26%  =
interrupts.CPU30.RES:Rescheduling_interrupts
>    371.50 =C2=B1 24%     -32.5%     250.75 =C2=B1  8%  =
interrupts.CPU34.RES:Rescheduling_interrupts
>    246.00 =C2=B1 23%     -32.5%     166.00 =C2=B1  7%  =
interrupts.CPU37.RES:Rescheduling_interrupts
>    550.25 =C2=B1 11%     +91.9%       1055 =C2=B1 28%  =
interrupts.CPU4.RES:Rescheduling_interrupts
>    165.75 =C2=B1 20%    +108.1%     345.00 =C2=B1 47%  =
interrupts.CPU47.NMI:Non-maskable_interrupts
>    165.75 =C2=B1 20%    +108.1%     345.00 =C2=B1 47%  =
interrupts.CPU47.PMI:Performance_monitoring_interrupts
>      2914 =C2=B1 10%     +50.3%       4380 =C2=B1 23%  =
interrupts.CPU48.CAL:Function_call_interrupts
>      6123 =C2=B1  9%     +43.8%       8808 =C2=B1 18%  =
interrupts.CPU5.CAL:Function_call_interrupts
>    146.25 =C2=B1 10%    +185.0%     416.75 =C2=B1 30%  =
interrupts.CPU5.NMI:Non-maskable_interrupts
>    146.25 =C2=B1 10%    +185.0%     416.75 =C2=B1 30%  =
interrupts.CPU5.PMI:Performance_monitoring_interrupts
>    477.50 =C2=B1 62%     -70.2%     142.50 =C2=B1 22%  =
interrupts.CPU6.NMI:Non-maskable_interrupts
>    477.50 =C2=B1 62%     -70.2%     142.50 =C2=B1 22%  =
interrupts.CPU6.PMI:Performance_monitoring_interrupts
>    580.00 =C2=B1 27%    +127.7%       1320 =C2=B1 42%  =
interrupts.CPU6.RES:Rescheduling_interrupts
>    479.50 =C2=B1 35%     -56.8%     207.25 =C2=B1 62%  =
interrupts.CPU62.NMI:Non-maskable_interrupts
>    479.50 =C2=B1 35%     -56.8%     207.25 =C2=B1 62%  =
interrupts.CPU62.PMI:Performance_monitoring_interrupts
>      1816 =C2=B1 14%     +35.6%       2463 =C2=B1 29%  =
interrupts.CPU65.CAL:Function_call_interrupts
>    142.25 =C2=B1100%     -66.3%      48.00 =C2=B1 10%  =
interrupts.CPU66.RES:Rescheduling_interrupts
>    459.50 =C2=B1 10%     +42.2%     653.50 =C2=B1 16%  =
interrupts.CPU7.RES:Rescheduling_interrupts
>      1282           +32.5%       1699 =C2=B1 27%  =
interrupts.CPU97.CAL:Function_call_interrupts
>      1301 =C2=B1  2%     +26.9%       1650 =C2=B1 28%  =
interrupts.CPU98.CAL:Function_call_interrupts
>     12.78 =C2=B1  2%      -1.9       10.92 =C2=B1  5%  =
perf-profile.calltrace.cycles-pp.ret_from_fork
>     12.78 =C2=B1  2%      -1.9       10.92 =C2=B1  5%  =
perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>      4.48 =C2=B1  6%      -1.6        2.90 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.re=
t_from_fork
>      4.55 =C2=B1  6%      -1.6        2.98 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.write_cache_pages.generic_writepages.do_w=
ritepages.__writeback_single_inode.writeback_sb_inodes
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.=
kthread.ret_from_fork
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.wb_writeback.wb_workfn.process_one_work.w=
orker_thread.kthread
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_wor=
kfn.process_one_work.worker_thread
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb=
.wb_writeback.wb_workfn.process_one_work
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_ino=
des.__writeback_inodes_wb.wb_writeback.wb_workfn
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.wr=
iteback_sb_inodes.__writeback_inodes_wb.wb_writeback
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.generic_writepages.do_writepages.__writeb=
ack_single_inode.writeback_sb_inodes.__writeback_inodes_wb
>      3.07 =C2=B1  8%      -1.3        1.80 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.__writepage.write_cache_pages.generic_wri=
tepages.do_writepages.__writeback_single_inode
>      2.98 =C2=B1  8%      -1.2        1.75 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.__block_write_full_page.__writepage.write=
_cache_pages.generic_writepages.do_writepages
>      2.06 =C2=B1  8%      -0.9        1.20 =C2=B1 11%  =
perf-profile.calltrace.cycles-pp.submit_bh_wbc.__block_write_full_page.__w=
ritepage.write_cache_pages.generic_writepages
>     14.52 =C2=B1  2%      -0.6       13.89        =
perf-profile.calltrace.cycles-pp.shrink_dentry_list.prune_dcache_sb.super_=
cache_scan.do_shrink_slab.shrink_slab
>     16.80            -0.6       16.21        =
perf-profile.calltrace.cycles-pp.prune_dcache_sb.super_cache_scan.do_shrin=
k_slab.shrink_slab.drop_slab_node
>      1.34 =C2=B1  9%      -0.6        0.78 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.submit_bio.submit_bh_wbc.__block_write_fu=
ll_page.__writepage.write_cache_pages
>      1.29 =C2=B1 10%      -0.5        0.77 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.submit_bio_noacct.submit_bio.submit_bh_wb=
c.__block_write_full_page.__writepage
>      0.94 =C2=B1  7%      -0.5        0.48 =C2=B1 59%  =
perf-profile.calltrace.cycles-pp.end_bio_bh_io_sync.blk_update_request.scs=
i_end_request.scsi_io_completion.blk_done_softirq
>      1.23 =C2=B1  7%      -0.4        0.81 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.blk_done_softirq.__softirqentry_text_star=
t.run_ksoftirqd.smpboot_thread_fn.kthread
>      1.21 =C2=B1  7%      -0.4        0.81 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.scsi_io_completion.blk_done_softirq.__sof=
tirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
>      1.21 =C2=B1  7%      -0.4        0.81 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.scsi_end_request.scsi_io_completion.blk_d=
one_softirq.__softirqentry_text_start.run_ksoftirqd
>      1.17 =C2=B1  7%      -0.4        0.77 =C2=B1 14%  =
perf-profile.calltrace.cycles-pp.blk_update_request.scsi_end_request.scsi_=
io_completion.blk_done_softirq.__softirqentry_text_start
>      2.99 =C2=B1  2%      -0.2        2.79 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.__d_drop.__dentry_kill.shrink_dentry_list=
.prune_dcache_sb.super_cache_scan
>      2.93 =C2=B1  2%      -0.2        2.73 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.___d_drop.__d_drop.__dentry_kill.shrink_d=
entry_list.prune_dcache_sb
>      2.30            -0.1        2.18 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.shrink_lock_dentry.shrink_dentry_list.pru=
ne_dcache_sb.super_cache_scan.do_shrink_slab
>      1.18 =C2=B1  4%      -0.1        1.09 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.=
__softirqentry_text_start.run_ksoftirqd
>      0.56 =C2=B1  6%      +0.1        0.70 =C2=B1  8%  =
perf-profile.calltrace.cycles-pp.__remove_hrtimer.__hrtimer_run_queues.hrt=
imer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
>      0.58 =C2=B1  4%      +0.1        0.73 =C2=B1  7%  =
perf-profile.calltrace.cycles-pp.ext4_discard_preallocations.ext4_clear_in=
ode.ext4_evict_inode.evict.dispose_list
>      0.79 =C2=B1  4%      +0.2        0.95 =C2=B1 10%  =
perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.=
tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
>      5.57            +0.3        5.88 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.evict.dispose_list.prune_icache_sb.super_=
cache_scan.do_shrink_slab
>      7.17            +0.4        7.55 =C2=B1  2%  =
perf-profile.calltrace.cycles-pp.dispose_list.prune_icache_sb.super_cache_=
scan.do_shrink_slab.shrink_slab
>      8.87            +0.5        9.33 =C2=B1  2%  =
perf-profile.calltrace.cycles-pp.prune_icache_sb.super_cache_scan.do_shrin=
k_slab.shrink_slab.drop_slab_node
>      5.66 =C2=B1  2%      +0.5        6.16 =C2=B1  4%  =
perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrt=
imer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
>      0.00            +0.6        0.57 =C2=B1  9%  =
perf-profile.calltrace.cycles-pp.timerqueue_del.__remove_hrtimer.__hrtimer=
_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
>      8.54 =C2=B1  2%      +0.9        9.47 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__=
sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_int=
errupt
>     26.26            +1.1       27.37 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_e=
nter_state.cpuidle_enter.do_idle.cpu_startup_entry
>     24.24 =C2=B1  2%      +1.1       25.38 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_ap=
ic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
>     14.93 =C2=B1  2%      +1.3       16.23 =C2=B1  2%  =
perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sy=
svec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.=
cpuidle_enter_state
>     14.28 =C2=B1  2%      +1.4       15.63 =C2=B1  3%  =
perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_int=
errupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_api=
c_timer_interrupt
>     15.05 =C2=B1  2%      +1.4       16.42 =C2=B1  2%  =
perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_time=
r_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_en=
ter
>     53.89 =C2=B1  2%      +2.1       56.02        =
perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>     53.09 =C2=B1  2%      +2.2       55.29        =
perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary=
.secondary_startup_64_no_verify
>     42.65 =C2=B1  2%      +2.2       44.86        =
perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle=
.cpu_startup_entry.start_secondary
>     43.61 =C2=B1  2%      +2.2       45.83        =
perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.s=
tart_secondary.secondary_startup_64_no_verify
>     53.16 =C2=B1  2%      +2.2       55.40        =
perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.seconda=
ry_startup_64_no_verify
>     53.16 =C2=B1  2%      +2.2       55.40        =
perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_v=
erify
>     12.81 =C2=B1  2%      -1.9       10.94 =C2=B1  5%  =
perf-profile.children.cycles-pp.ret_from_fork
>     12.78 =C2=B1  2%      -1.9       10.92 =C2=B1  5%  =
perf-profile.children.cycles-pp.kthread
>      4.48 =C2=B1  6%      -1.6        2.90 =C2=B1  9%  =
perf-profile.children.cycles-pp.process_one_work
>      4.55 =C2=B1  6%      -1.6        2.98 =C2=B1  9%  =
perf-profile.children.cycles-pp.worker_thread
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.children.cycles-pp.wb_workfn
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.children.cycles-pp.wb_writeback
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.children.cycles-pp.__writeback_inodes_wb
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.children.cycles-pp.writeback_sb_inodes
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.children.cycles-pp.__writeback_single_inode
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.children.cycles-pp.do_writepages
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.children.cycles-pp.generic_writepages
>      3.70 =C2=B1  7%      -1.5        2.19 =C2=B1 10%  =
perf-profile.children.cycles-pp.write_cache_pages
>      3.07 =C2=B1  8%      -1.3        1.80 =C2=B1 10%  =
perf-profile.children.cycles-pp.__writepage
>      2.98 =C2=B1  8%      -1.2        1.75 =C2=B1 10%  =
perf-profile.children.cycles-pp.__block_write_full_page
>      2.06 =C2=B1  8%      -0.9        1.20 =C2=B1 10%  =
perf-profile.children.cycles-pp.submit_bh_wbc
>      1.78 =C2=B1  6%      -0.6        1.13 =C2=B1 17%  =
perf-profile.children.cycles-pp.blk_done_softirq
>      1.76 =C2=B1  6%      -0.6        1.11 =C2=B1 17%  =
perf-profile.children.cycles-pp.scsi_io_completion
>      1.76 =C2=B1  6%      -0.6        1.11 =C2=B1 17%  =
perf-profile.children.cycles-pp.scsi_end_request
>     14.55 =C2=B1  2%      -0.6       13.92        =
perf-profile.children.cycles-pp.shrink_dentry_list
>      1.68 =C2=B1  7%      -0.6        1.07 =C2=B1 17%  =
perf-profile.children.cycles-pp.blk_update_request
>     16.80            -0.6       16.21        =
perf-profile.children.cycles-pp.prune_dcache_sb
>      1.34 =C2=B1 10%      -0.6        0.78 =C2=B1  9%  =
perf-profile.children.cycles-pp.submit_bio
>      1.29 =C2=B1 10%      -0.5        0.77 =C2=B1  8%  =
perf-profile.children.cycles-pp.submit_bio_noacct
>      1.35 =C2=B1  7%      -0.5        0.84 =C2=B1 18%  =
perf-profile.children.cycles-pp.end_bio_bh_io_sync
>      0.97 =C2=B1  8%      -0.3        0.62 =C2=B1 17%  =
perf-profile.children.cycles-pp.end_page_writeback
>      0.79 =C2=B1  6%      -0.3        0.49 =C2=B1  9%  =
perf-profile.children.cycles-pp.blk_mq_submit_bio
>      0.67 =C2=B1 12%      -0.3        0.40 =C2=B1 12%  =
perf-profile.children.cycles-pp.__test_set_page_writeback
>      0.57 =C2=B1  8%      -0.2        0.35 =C2=B1 30%  =
perf-profile.children.cycles-pp.sysvec_call_function_single
>      0.57 =C2=B1  8%      -0.2        0.35 =C2=B1 31%  =
perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>      3.01 =C2=B1  2%      -0.2        2.80 =C2=B1  3%  =
perf-profile.children.cycles-pp.__d_drop
>      0.55 =C2=B1 10%      -0.2        0.34 =C2=B1 21%  =
perf-profile.children.cycles-pp.test_clear_page_writeback
>      2.94 =C2=B1  2%      -0.2        2.75 =C2=B1  3%  =
perf-profile.children.cycles-pp.___d_drop
>      0.42 =C2=B1  8%      -0.2        0.23 =C2=B1 17%  =
perf-profile.children.cycles-pp.bio_alloc_bioset
>      0.40 =C2=B1 16%      -0.2        0.23 =C2=B1 14%  =
perf-profile.children.cycles-pp.submit_bio_checks
>      0.51 =C2=B1 12%      -0.2        0.36 =C2=B1  8%  =
perf-profile.children.cycles-pp.kmem_cache_alloc
>      0.32 =C2=B1 12%      -0.1        0.17 =C2=B1 19%  =
perf-profile.children.cycles-pp.mempool_alloc
>      0.32 =C2=B1  6%      -0.1        0.18 =C2=B1 10%  =
perf-profile.children.cycles-pp.clear_page_dirty_for_io
>      0.38 =C2=B1  8%      -0.1        0.25 =C2=B1 17%  =
perf-profile.children.cycles-pp.rotate_reclaimable_page
>      2.31            -0.1        2.19 =C2=B1  3%  =
perf-profile.children.cycles-pp.shrink_lock_dentry
>      0.45 =C2=B1 11%      -0.1        0.33 =C2=B1  5%  =
perf-profile.children.cycles-pp.try_to_wake_up
>      0.28 =C2=B1 18%      -0.1        0.16 =C2=B1 27%  =
perf-profile.children.cycles-pp.end_buffer_async_write
>      0.28 =C2=B1  7%      -0.1        0.18 =C2=B1 21%  =
perf-profile.children.cycles-pp.blk_attempt_plug_merge
>      0.19 =C2=B1 15%      -0.1        0.09 =C2=B1  7%  =
perf-profile.children.cycles-pp.percpu_counter_add_batch
>      0.16 =C2=B1 16%      -0.1        0.08 =C2=B1 68%  =
perf-profile.children.cycles-pp.__slab_alloc
>      0.29 =C2=B1 11%      -0.1        0.21 =C2=B1 15%  =
perf-profile.children.cycles-pp.pagevec_lru_move_fn
>      0.21 =C2=B1 21%      -0.1        0.13 =C2=B1 11%  =
perf-profile.children.cycles-pp.open64
>      0.28 =C2=B1 14%      -0.1        0.20 =C2=B1  4%  =
perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>      0.15 =C2=B1 19%      -0.1        0.07 =C2=B1 71%  =
perf-profile.children.cycles-pp.fscrypt_drop_inode
>      0.17 =C2=B1 13%      -0.1        0.10 =C2=B1 11%  =
perf-profile.children.cycles-pp.bio_attempt_back_merge
>      0.15 =C2=B1 15%      -0.1        0.07 =C2=B1 67%  =
perf-profile.children.cycles-pp.___slab_alloc
>      0.24 =C2=B1 14%      -0.1        0.16 =C2=B1 11%  =
perf-profile.children.cycles-pp.pagevec_move_tail_fn
>      0.14 =C2=B1 21%      -0.1        0.07 =C2=B1 19%  =
perf-profile.children.cycles-pp.blk_throtl_bio
>      0.21 =C2=B1 14%      -0.1        0.15 =C2=B1  9%  =
perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
>      0.10 =C2=B1 14%      -0.1        0.04 =C2=B1101%  =
perf-profile.children.cycles-pp.allocate_slab
>      0.12 =C2=B1 25%      -0.1        0.06 =C2=B1 26%  =
perf-profile.children.cycles-pp.__mod_lruvec_state
>      0.20 =C2=B1 13%      -0.1        0.15 =C2=B1 11%  =
perf-profile.children.cycles-pp.scsi_queue_rq
>      0.10 =C2=B1 25%      -0.1        0.05 =C2=B1 62%  =
perf-profile.children.cycles-pp.__close_nocancel
>      0.08 =C2=B1 15%      -0.1        0.03 =C2=B1100%  =
perf-profile.children.cycles-pp.__split_vma
>      0.17 =C2=B1  8%      -0.1        0.12 =C2=B1  9%  =
perf-profile.children.cycles-pp.can_stop_idle_tick
>      0.15 =C2=B1 19%      -0.0        0.11 =C2=B1 28%  =
perf-profile.children.cycles-pp.get_page_from_freelist
>      0.09 =C2=B1 20%      -0.0        0.05 =C2=B1 62%  =
perf-profile.children.cycles-pp.__vm_munmap
>      0.15 =C2=B1 10%      -0.0        0.11 =C2=B1 11%  =
perf-profile.children.cycles-pp.schedule_timeout
>      0.14 =C2=B1 13%      -0.0        0.10 =C2=B1 25%  =
perf-profile.children.cycles-pp.call_timer_fn
>      0.09 =C2=B1 13%      -0.0        0.05 =C2=B1 58%  =
perf-profile.children.cycles-pp.enqueue_entity
>      0.23 =C2=B1  7%      -0.0        0.20 =C2=B1  4%  =
perf-profile.children.cycles-pp.rcu_segcblist_enqueue
>      0.23 =C2=B1  6%      -0.0        0.20 =C2=B1  5%  =
perf-profile.children.cycles-pp.rcu_gp_kthread
>      0.17 =C2=B1  9%      -0.0        0.14 =C2=B1  3%  =
perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
>      0.10 =C2=B1  8%      -0.0        0.08 =C2=B1 19%  =
perf-profile.children.cycles-pp.enqueue_task_fair
>      0.04 =C2=B1 60%      +0.0        0.08 =C2=B1  5%  =
perf-profile.children.cycles-pp.rcu_irq_enter
>      0.06 =C2=B1 11%      +0.0        0.10 =C2=B1 12%  =
perf-profile.children.cycles-pp.arch_cpu_idle_exit
>      0.14 =C2=B1  7%      +0.0        0.19 =C2=B1 16%  =
perf-profile.children.cycles-pp.update_dl_rq_load_avg
>      0.07 =C2=B1 58%      +0.1        0.12 =C2=B1 12%  =
perf-profile.children.cycles-pp.delay_tsc
>      0.44 =C2=B1  5%      +0.1        0.49 =C2=B1  4%  =
perf-profile.children.cycles-pp.truncate_inode_pages_final
>      0.18 =C2=B1 26%      +0.1        0.23 =C2=B1  5%  =
perf-profile.children.cycles-pp.update_ts_time_stats
>      0.00            +0.1        0.07 =C2=B1 17%  =
perf-profile.children.cycles-pp.perf_iterate_sb
>      0.11 =C2=B1 17%      +0.1        0.19 =C2=B1 21%  =
perf-profile.children.cycles-pp.tick_program_event
>      0.17 =C2=B1 17%      +0.1        0.24 =C2=B1  4%  =
perf-profile.children.cycles-pp.cpuidle_not_available
>      0.46 =C2=B1  6%      +0.1        0.54 =C2=B1  6%  =
perf-profile.children.cycles-pp.__x86_retpoline_rax
>      0.02 =C2=B1173%      +0.1        0.11 =C2=B1 25%  =
perf-profile.children.cycles-pp.cpuidle_get_cpu_driver
>      0.80 =C2=B1  4%      +0.1        0.90 =C2=B1  2%  =
perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>      0.58 =C2=B1 10%      +0.1        0.71 =C2=B1  7%  =
perf-profile.children.cycles-pp.enqueue_hrtimer
>      1.74            +0.1        1.87 =C2=B1  4%  =
perf-profile.children.cycles-pp.__list_del_entry_valid
>      0.45 =C2=B1 12%      +0.1        0.59 =C2=B1  6%  =
perf-profile.children.cycles-pp.timerqueue_add
>      0.59 =C2=B1  4%      +0.1        0.73 =C2=B1  7%  =
perf-profile.children.cycles-pp.ext4_discard_preallocations
>      0.87 =C2=B1  6%      +0.2        1.02 =C2=B1 10%  =
perf-profile.children.cycles-pp.rcu_sched_clock_irq
>      0.53 =C2=B1  6%      +0.2        0.71 =C2=B1  9%  =
perf-profile.children.cycles-pp.timerqueue_del
>      0.66 =C2=B1  9%      +0.2        0.84 =C2=B1  8%  =
perf-profile.children.cycles-pp.__remove_hrtimer
>      0.26 =C2=B1 35%      +0.2        0.45 =C2=B1 18%  =
perf-profile.children.cycles-pp.timekeeping_max_deferment
>      7.18            +0.4        7.55 =C2=B1  2%  =
perf-profile.children.cycles-pp.dispose_list
>      5.14            +0.4        5.53 =C2=B1  3%  =
perf-profile.children.cycles-pp.kmem_cache_free
>      8.87            +0.5        9.33 =C2=B1  2%  =
perf-profile.children.cycles-pp.prune_icache_sb
>     10.50 =C2=B1  2%      +1.7       12.19 =C2=B1 11%  =
perf-profile.children.cycles-pp.__hrtimer_run_queues
>     44.20 =C2=B1  2%      +2.1       46.30        =
perf-profile.children.cycles-pp.cpuidle_enter
>     16.58 =C2=B1  2%      +2.1       18.70 =C2=B1  8%  =
perf-profile.children.cycles-pp.hrtimer_interrupt
>     53.89 =C2=B1  2%      +2.1       56.02        =
perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>     53.89 =C2=B1  2%      +2.1       56.02        =
perf-profile.children.cycles-pp.cpu_startup_entry
>     53.89 =C2=B1  2%      +2.1       56.02        =
perf-profile.children.cycles-pp.do_idle
>     44.06 =C2=B1  2%      +2.2       46.23        =
perf-profile.children.cycles-pp.cpuidle_enter_state
>     28.19 =C2=B1  2%      +2.2       30.37 =C2=B1  3%  =
perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>     17.26            +2.2       19.47 =C2=B1  7%  =
perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>     53.16 =C2=B1  2%      +2.2       55.40        =
perf-profile.children.cycles-pp.start_secondary
>     29.75 =C2=B1  2%      +2.3       32.02 =C2=B1  3%  =
perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>      2.56 =C2=B1  2%      -0.3        2.25 =C2=B1  7%  =
perf-profile.self.cycles-pp.___d_drop
>      0.77 =C2=B1  6%      -0.2        0.59 =C2=B1 10%  =
perf-profile.self.cycles-pp.tick_nohz_next_event
>      0.12 =C2=B1 23%      -0.1        0.04 =C2=B1101%  =
perf-profile.self.cycles-pp.fscrypt_drop_inode
>      0.16 =C2=B1 10%      -0.1        0.08 =C2=B1 10%  =
perf-profile.self.cycles-pp.percpu_counter_add_batch
>      0.15 =C2=B1 22%      -0.1        0.09 =C2=B1 20%  =
perf-profile.self.cycles-pp.__test_set_page_writeback
>      0.09 =C2=B1 14%      -0.1        0.03 =C2=B1100%  =
perf-profile.self.cycles-pp.clear_page_dirty_for_io
>      0.17 =C2=B1  8%      -0.1        0.11 =C2=B1 21%  =
perf-profile.self.cycles-pp.__block_write_full_page
>      0.19 =C2=B1 21%      -0.1        0.13 =C2=B1  3%  =
perf-profile.self.cycles-pp.kmem_cache_alloc
>      0.19 =C2=B1  5%      -0.1        0.14 =C2=B1 10%  =
perf-profile.self.cycles-pp.cpuidle_governor_latency_req
>      0.12 =C2=B1  7%      -0.1        0.07 =C2=B1 62%  =
perf-profile.self.cycles-pp.cpuidle_enter
>      0.10 =C2=B1 14%      -0.1        0.05 =C2=B1 60%  =
perf-profile.self.cycles-pp.end_bio_bh_io_sync
>      0.17 =C2=B1  8%      -0.1        0.12 =C2=B1  9%  =
perf-profile.self.cycles-pp.can_stop_idle_tick
>      0.23 =C2=B1  7%      -0.0        0.19 =C2=B1  3%  =
perf-profile.self.cycles-pp.rcu_segcblist_enqueue
>      0.08 =C2=B1 23%      -0.0        0.04 =C2=B1 63%  =
perf-profile.self.cycles-pp.find_get_pages_range_tag
>      0.08 =C2=B1  6%      -0.0        0.04 =C2=B1 59%  =
perf-profile.self.cycles-pp.__d_drop
>      0.09 =C2=B1 13%      +0.0        0.12 =C2=B1 15%  =
perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
>      0.10 =C2=B1 10%      +0.0        0.14 =C2=B1  5%  =
perf-profile.self.cycles-pp.tick_sched_handle
>      0.36 =C2=B1  5%      +0.0        0.40 =C2=B1  2%  =
perf-profile.self.cycles-pp.__x86_retpoline_rax
>      0.09 =C2=B1 27%      +0.0        0.13 =C2=B1 17%  =
perf-profile.self.cycles-pp.tick_nohz_tick_stopped
>      0.16 =C2=B1  7%      +0.1        0.21 =C2=B1 16%  =
perf-profile.self.cycles-pp.timerqueue_del
>      0.07 =C2=B1 58%      +0.1        0.12 =C2=B1 12%  =
perf-profile.self.cycles-pp.delay_tsc
>      0.01 =C2=B1173%      +0.1        0.07 =C2=B1  7%  =
perf-profile.self.cycles-pp.arch_cpu_idle_exit
>      0.18 =C2=B1 10%      +0.1        0.23 =C2=B1 17%  =
perf-profile.self.cycles-pp.update_blocked_averages
>      0.13 =C2=B1  8%      +0.1        0.19 =C2=B1 16%  =
perf-profile.self.cycles-pp.update_dl_rq_load_avg
>      0.11 =C2=B1 15%      +0.1        0.18 =C2=B1 22%  =
perf-profile.self.cycles-pp.tick_program_event
>      0.00            +0.1        0.07 =C2=B1 17%  =
perf-profile.self.cycles-pp.rcu_irq_enter
>      0.19 =C2=B1  5%      +0.1        0.26 =C2=B1 11%  =
perf-profile.self.cycles-pp.__hrtimer_get_next_event
>      0.10 =C2=B1 27%      +0.1        0.17 =C2=B1  8%  =
perf-profile.self.cycles-pp.update_ts_time_stats
>      0.27 =C2=B1  6%      +0.1        0.34 =C2=B1  8%  =
perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
>      0.16 =C2=B1 19%      +0.1        0.24 =C2=B1  3%  =
perf-profile.self.cycles-pp.cpuidle_not_available
>      0.40 =C2=B1  6%      +0.1        0.48 =C2=B1 10%  =
perf-profile.self.cycles-pp.ext4_discard_preallocations
>      0.02 =C2=B1173%      +0.1        0.10 =C2=B1 22%  =
perf-profile.self.cycles-pp.cpuidle_get_cpu_driver
>      0.33 =C2=B1 11%      +0.1        0.42 =C2=B1 14%  =
perf-profile.self.cycles-pp.rb_erase
>      0.20 =C2=B1 16%      +0.1        0.29 =C2=B1  7%  =
perf-profile.self.cycles-pp.timerqueue_add
>      0.18 =C2=B1  8%      +0.1        0.28 =C2=B1 18%  =
perf-profile.self.cycles-pp.irq_exit_rcu
>      0.71 =C2=B1  5%      +0.1        0.84 =C2=B1  2%  =
perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>      0.67 =C2=B1  8%      +0.2        0.84 =C2=B1 12%  =
perf-profile.self.cycles-pp.rcu_sched_clock_irq
>      0.25 =C2=B1 36%      +0.2        0.45 =C2=B1 18%  =
perf-profile.self.cycles-pp.timekeeping_max_deferment
>=20
>=20
>=20
>                 fxmark.hdd_ext4_no_jnl_MWCL_2_bufferedio.works_sec
>=20
>  23000 =
+-------------------------------------------------------------------+
>        |.+..+      =
+..+.+.+..+.+..+.+..+.+.+..+.+..+.+..+.+.+..+.+..+.+..+.|
>  22500 |-+                                                             =
    |
>  22000 |-+                                                             =
    |
>        |                                                               =
    |
>  21500 |-+                                                             =
    |
>        |           O  O           O        O  O      O  O        O     =
    |
>  21000 |-+              O    O O    O  O O      O  O      O O  O       =
    |
>        |                  O                                            =
    |
>  20500 |-+                                                             =
    |
>  20000 |-+                                                             =
    |
>        |                                                               =
    |
>  19500 |-+  O    O                                                     =
    |
>        | O    O                                                        =
    |
>  19000 =
+-------------------------------------------------------------------+
>=20
>=20
>                fxmark.hdd_ext4_no_jnl_MWCL_2_bufferedio.iowait_sec
>=20
>  2.5 =
+---------------------------------------------------------------------+
>      |                         O                                       =
    |
>      |       O            O O            O          O            O     =
    |
>    2 |-+                               O         O         O           =
    |
>      |  O                         O O                         O    O   =
    |
>      |         O  O  O O                    O O       O  O             =
    |
>  1.5 |-+  O                                                            =
    |
>      |                                                                 =
    |
>    1 |-+                                                               =
    |
>      |                                                                 =
    |
>      |                                                                 =
    |
>  0.5 |-+                                                               =
    |
>      |                                                                 =
    |
>      |                                                                 =
    |
>    0 =
+---------------------------------------------------------------------+
>=20
>=20
>               fxmark.hdd_ext4_no_jnl_MWCL_2_bufferedio.iowait_util
>=20
>    4 =
+---------------------------------------------------------------------+
>      |                    O O  O                                 O     =
    |
>  3.5 |-+     O                         O O       O  O      O           =
    |
>    3 |-+                                                               =
    |
>      |  O            O            O O                         O    O   =
    |
>  2.5 |-+  O    O  O    O                    O O       O  O             =
    |
>      |                                                                 =
    |
>    2 |-+                                                               =
    |
>      |                                                                 =
    |
>  1.5 |-+                                                               =
    |
>    1 |-+                                                               =
    |
>      |                                                                 =
    |
>  0.5 |-+                                                               =
    |
>      |                                                                 =
    |
>    0 =
+---------------------------------------------------------------------+
>=20
>=20
>                   fxmark.hdd_ext4_no_jnl_MWCL_1_bufferedio.works
>=20
>  320000 =
+------------------------------------------------------------------+
>         |. .. +  .+.+.+..    .+.+.+..+.+..+.+.+..+.+.+..+.  =
.+.+.+..+.+..+.|
>  310000 |-+    +.        +.+.                             +.           =
    |
>         |                                                              =
    |
>  300000 |-+                                                            =
    |
>         |                                                              =
    |
>  290000 |-+              O        O           O         O              =
    |
>         |           O O    O  O O      O  O O    O O O    O  O   O     =
    |
>  280000 |-+                          O                         O       =
    |
>         |                                                              =
    |
>  270000 |-+                                                            =
    |
>         |    O                                                         =
    |
>  260000 |-O    O  O                                                    =
    |
>         |                                                              =
    |
>  250000 =
+------------------------------------------------------------------+
>=20
>=20
>                 fxmark.hdd_ext4_no_jnl_MWCL_1_bufferedio.works_sec
>=20
>  10800 =
+-------------------------------------------------------------------+
>  10600 |-+  +        .+                           .+.  .+   +..        =
    |
>        |. .. +  .+.+.  + .+..+.+..+.+..+.+.+..+.+.   +.  + +   =
+.+..+.+..+.|
>  10400 |-+    +.        +                                 +            =
    |
>  10200 |-+                                                             =
    |
>  10000 |-+                                                             =
    |
>   9800 |-+                                                             =
    |
>        |                O         O                                    =
    |
>   9600 |-+                   O           O O  O    O O  O O O    O     =
    |
>   9400 |-+         O  O   O    O    O  O        O              O       =
    |
>   9200 |-+                                                             =
    |
>   9000 |-+                                                             =
    |
>        |                                                               =
    |
>   8800 |-O  O O                                                        =
    |
>   8600 =
+-------------------------------------------------------------------+
>=20
>=20
> [*] bisect-good sample
> [O] bisect-bad  sample
>=20
>=20
>=20
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are =
provided
> for informational purposes only. Any difference in system hardware or =
software
> design or configuration may affect actual performance.
>=20
>=20
> Thanks,
> Oliver Sang
>=20
> =
<config-5.11.0-rc6-00009-gef4eebad9c01><job-script.txt><job.yaml><reproduc=
e.txt>


Cheers, Andreas






--Apple-Mail=_848A5670-D03E-4EB9-B3CC-3C5A271502CA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmA4aYEACgkQcqXauRfM
H+BAWRAApOacwQz+bk48T2q+M9ug5C04KKfqpG12+kfjh05SyrPJp0xNpyoSM5Or
6W1/J+N+KWwt+kX3OSv3A5xoLow7WERaNORPZLwb11vqcbP9ox3OsiiVD2lEzDiq
gFnkQEnpYLpmok1XJwaPsnVhFaq7lmErR10trPCDucSlJA+Hz/aG8ShIT0QH3Ysk
VYFVAnOy2/Zis6APnndCYhxhsYXDlCARhmO+WU/SazvbIQpfSOUlj/ze+wg+6qfA
/t9VMi1sEP5GX/hfkrzPf9nRRIoIHCquX2FHLj0Ys+KZOx8O6f6+aEwtLWbwAoPA
IqQx9On51kLj3o2W5gjFxrqwLrVNH9It5Aam949/FyLE1wpEyRpBvOi2OLYK5JTh
wZw4lK+hOvXEvys9SgqNsCo/CmrAiHDwSTblodp/jKDdkmkTxE2Urrc6CV4YDEf8
HnCvm2Di9G/3NVRWNo69UgCO4waEAUp62h85GlaVqOs7/SBucBFSOrGZUacczogB
ya0/JttoDe3ysu5h9W5rrfRM22unb1Jh6iMDhMbw8FsD6mJFdwU7N2D1QVbkrMFv
5B0P0ZF5FhnqIHPNp+Om2WIDJqF/baRYkil4jtwAmqbX3T30Kdbn5wcxOzFgjm33
9qqVEIxG647+iqFdtZR22Xz2Ppd1qOQZurhiFCkI1/qZeJEALtc=
=N86l
-----END PGP SIGNATURE-----

--Apple-Mail=_848A5670-D03E-4EB9-B3CC-3C5A271502CA--
