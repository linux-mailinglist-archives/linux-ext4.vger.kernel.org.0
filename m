Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167EC70585D
	for <lists+linux-ext4@lfdr.de>; Tue, 16 May 2023 22:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjEPUJE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 May 2023 16:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEPUJE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 May 2023 16:09:04 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB2D768C
        for <linux-ext4@vger.kernel.org>; Tue, 16 May 2023 13:08:58 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7835b0bd5c8so32748241.0
        for <linux-ext4@vger.kernel.org>; Tue, 16 May 2023 13:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684267738; x=1686859738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DBoVho2ELfwf8xFod3p2Xy8hTGWnwzQmWp1BhB8w9o=;
        b=o9t4f7WwcdoQ/ufMDCYBJxxJoWiDW5b99hO3LW4Ce1Cwer2T6WUpp+kfMFQQ0uT+qE
         Y3EH15M0VA1ESBSdgY3oduuSTbfbn7tM0exdZfeY7zNIrDMomucT2eiwndZvn/06svnC
         mFeRrdTZdr4M/BHzNxusseXjUMwOB+iivcQ8qSfSpXnaXh1xNWwjMRLcxLnBBXHYUBcD
         ez+kdMdBA16XYBvX1o4n7B0AR5aWdQk577fGEgW9BZk1POai7M6gH7y/7ANQ5XVtoXyf
         5Wspxm7dmTyPDjGWYQStWk13FRwfFxh2j/bkovfedC7PrJU9EBUA7k9MdVsMqykQGl/m
         laEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684267738; x=1686859738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DBoVho2ELfwf8xFod3p2Xy8hTGWnwzQmWp1BhB8w9o=;
        b=J/AStIi0Ut6k+boRGU3uNM5tSwghjrsNc9zUPzQUijgatTxvcQVwBCTWuMi4Ttxl+3
         ZOc56wwCpeYGSqFGZ2onfD67XBqoWRyX9QjBUyrxzKfrUyNxbXRvvYsiqnWK0vRP+r8u
         TXUWLVVv8dsknNRH695cOAzF88LCJ7easnjklg5Oqa7huBvLOiAjos5favav8hR8d90F
         ELKzyHvFeLu/9PwmbayRvYRwMNFlIDzli8gcXa5e2j5nAwaSvnEWVCrE32sbC5OtdxBD
         rshHU02IfksmWdd/v5ALd9T4ZbOcCXQrT3hM4aG0MIQfaZTbQBcQnwVBjVxaJLFnc5P1
         UoXg==
X-Gm-Message-State: AC+VfDzjBns0GpO+MPmvvD/fOFl8MpRcEHize62szcVEtFh2dZla0MUk
        ZFHnxIziF7BwYoPCnaBWjk8sTEOq2SkvOkkL3WFbaA==
X-Google-Smtp-Source: ACHHUZ4qyeqQ2VF116h5i3lUPhXtdRr98E0TNIbj6xeeFCRymVRG6Qo8zUoadLuHlDfIbPZk39vCIUi319M/Na5Pz9E=
X-Received: by 2002:a67:e9c6:0:b0:436:18b:6a32 with SMTP id
 q6-20020a67e9c6000000b00436018b6a32mr13567983vso.30.1684267737751; Tue, 16
 May 2023 13:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230515161658.228491273@linuxfoundation.org>
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 May 2023 01:38:46 +0530
Message-ID: <CA+G9fYthEih_mti7PdjCjif9crHqWV_erk-05iWUgD7wMJTtkQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/116] 4.14.315-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-cifs@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 15 May 2023 at 22:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.315 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.315-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64 and i386.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

We have recently upgraded our selftest sources to stable-rc 6.3 and
running on stable rc 6.1, 5.15, 5.10, 5.4, 4.19 and 4.14 kernels.

List of test regressions:
=3D=3D=3D=3D=3D=3D=3D=3D

ltp-syscalls
  - fallocate06 - FAILS on arm and arm64.

kselftest-kvm
  - kvm_xapic_state_test - FAILS on x86.

=3D=3D=3D=3D=3D=3D

ltp-syscalls
  - fallocate06 - FAILS on arm and arm64.

fallocate06.c:155: TFAIL: fallocate(FALLOC_FL_PUNCH_HOLE |
FALLOC_FL_KEEP_SIZE) failed unexpectedly: ENOSPC (28)

Test log links,
=3D=3D=3D=3D=3D=3D=3D=3D
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4=
.14.314-117-g854d9237fbd3/testrun/17026942/suite/ltp-syscalls/test/fallocat=
e06/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4=
.14.314-117-g854d9237fbd3/testrun/17026942/suite/ltp-syscalls/test/fallocat=
e06/log

=3D=3D=3D=3D=3D=3D=3D=3D=3D
kselftest-kvm
  - kvm_xapic_state_test - - FAILS on x86.

# selftests: kvm: xapic_state_test
# =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
#   x86_64/xapic_state_test.c:147: apic_id =3D=3D expected
#   pid=3D4581 tid=3D4581 errno=3D4 - Interrupted system call
#      1 0x0000000000402bac: ?? ??:0
#      2 0x00000000004025ba: ?? ??:0
#      3 0x00007f8bc10e557a: ?? ??:0
#      4 0x00007f8bc10e562f: ?? ??:0
#      5 0x0000000000402624: ?? ??:0
#   APIC_ID not set back to xAPIC format; wanted =3D 1000000, got =3D 1
not ok 46 selftests: kvm: xapic_state_test # exit=3D254

Test log links,
=3D=3D=3D=3D=3D=3D=3D=3D
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4=
.14.314-117-g854d9237fbd3/testrun/17025913/suite/kselftest-kvm/test/kvm_xap=
ic_state_test/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4=
.14.314-117-g854d9237fbd3/testrun/17025913/suite/kselftest-kvm/test/kvm_xap=
ic_state_test/log

## Build
* kernel: 4.14.315-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: 854d9237fbd3cc4b72183256a0fa5edf2f967d88
* git describe: v4.14.314-117-g854d9237fbd3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.314-117-g854d9237fbd3

## Test Regressions (compared to v4.14.311-134-g05f80276ba11)

* dragonboard-410c, ltp-syscalls
  - fallocate06

* juno-r2, ltp-syscalls
  - fallocate06

* juno-r2-kasan, ltp-syscalls
  - fallocate06

* x86, kselftest-kvm
  - kvm_xapic_state_test

## Metric Regressions (compared to v4.14.311-134-g05f80276ba11)

## Test Fixes (compared to v4.14.311-134-g05f80276ba11)

## Metric Fixes (compared to v4.14.311-134-g05f80276ba11)

## Test result summary
total: 79873, pass: 67657, fail: 2892, skip: 9170, xfail: 154

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 108 total, 104 passed, 4 failed
* arm64: 35 total, 31 passed, 4 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 21 total, 21 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 8 total, 7 passed, 1 failed
* s390: 6 total, 5 passed, 1 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 23 passed, 4 failed

## Test suites summary
* boot
* fwts
* igt-gpu-tools
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-net
* kselftest-net-forwarding
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
