Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDE705793
	for <lists+linux-ext4@lfdr.de>; Tue, 16 May 2023 21:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEPTkc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 May 2023 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjEPTka (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 May 2023 15:40:30 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD064A26A
        for <linux-ext4@vger.kernel.org>; Tue, 16 May 2023 12:40:05 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-77d0fcbce6bso18207241.1
        for <linux-ext4@vger.kernel.org>; Tue, 16 May 2023 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684265957; x=1686857957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl0KxKY/sUcM54GB5tUsJdCgfaOj1mAl6bkpff/gM1k=;
        b=dsbLYDRucXeFfy0Q/wCYCvEpNLRRzLYvTikvSdUg55vOz24AO+E/QwEMZYFCLgsIUL
         TP2kqL/XSO9xo4qYSlxpIMcnDRh93iGsYH1x1Of0ShspCO1GxrShBtdFerCbFQ7XNOOS
         h1ROfA6eOs4GIHyR6q/h/4u+C8FOWvtUBAr35zxQeSISTQ+fm7utqJjvjB9bP+jW+ys1
         oT2uZk/G+oUv+KhJPlOiv/tHPy5vl/Y6MWIsLReICSp28OninHw7eMvOT97IJ4XYogrk
         fq5n2E8l+4lUW3JwfVBNlMCpWk91W3x46+13OI/IntSRkIJHnKz2tn+HbVkm/e/9QXEi
         ZVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684265957; x=1686857957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl0KxKY/sUcM54GB5tUsJdCgfaOj1mAl6bkpff/gM1k=;
        b=RFZsB9llk1DA/ACBn/72mlWQaXe1vvYNylN4HdcllL+gufmTv1jKfYtSGJOlk8roBP
         coinDDdKFF4eIzjjK/yulTgrLt9RBxf1zqVC4u8NQ9Y3wmDoLQ82+p4NS5QVLsHDka91
         KSRBB5QWlclEIivFKjf9wJQAxPGr5B1GabvRzPRQE14bNhjaCsO5lIvBWG1byCeZcoIj
         yEuqgJ1SKUg//Qh55HIWgZOb40P7qCUCKGBlJG0C4zQqLWF1QCeaEHrxUKeo5lMN5j47
         lN0ZkUorjUA/6dbpphwfALzJiEhAmo6Vuz9X/sFex5C4uj7bnJ0ct5nI/CpMi6MWTuAR
         +8NA==
X-Gm-Message-State: AC+VfDztbAmz+TESiKfv5MnPI2k8lQbuQvpKXycqGUv2nGtCV9A5o6ej
        scXHh1zkYh50YI79Q8E3GsaA9YIYBWe7EbghiHuDlw==
X-Google-Smtp-Source: ACHHUZ5vIZUSmno0LG6tQNjwPdpLccVbcF3x/foJyasbY5MnT2o8uMNXCaMfo51qg7XyO1B4jwPULmnkSizsP8h04ik=
X-Received: by 2002:a1f:bf47:0:b0:453:9057:1693 with SMTP id
 p68-20020a1fbf47000000b0045390571693mr7211731vkf.5.1684265956844; Tue, 16 May
 2023 12:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230515161707.203549282@linuxfoundation.org>
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 May 2023 01:09:05 +0530
Message-ID: <CA+G9fYtjmJS893BLx7ggwMXvqzqpiRU7BrvgRjE8d+epJYLrGQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/191] 4.19.283-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-cifs@vger.kernel.org
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

On Mon, 15 May 2023 at 22:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.283 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.283-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64 and i386.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

1) ltp-syscalls fallocate06 - FAILS on arm and arm64 on 4.19 and 4.14.

2) We have recently upgraded our selftest sources to stable-rc 6.3 and
running on stable rc 6.1, 5.15, 5.10, 5.4, 4.19 and 4.14 kernels.

List of test regressions:
=3D=3D=3D=3D=3D=3D=3D=3D

ltp-syscalls
  - fallocate06

kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

kselftest-memfd
  - memfd_memfd_test

kselftest-rseq
  - rseq_basic_test

 kselftest-kvm
  - kvm_xapic_state_test

=3D=3D=3D=3D=3D=3D

ltp-syscalls
  - fallocate06 - FAILS on arm and arm64 on 4.19 and 4.14

fallocate06.c:155: TFAIL: fallocate(FALLOC_FL_PUNCH_HOLE |
FALLOC_FL_KEEP_SIZE) failed unexpectedly: ENOSPC (28)

Test log links,
=3D=3D=3D=3D=3D=3D=3D=3D
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4=
.19.282-192-g373cdd8d6123/testrun/17027069/suite/ltp-syscalls/test/fallocat=
e06/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4=
.19.282-192-g373cdd8d6123/testrun/17027069/suite/ltp-syscalls/test/fallocat=
e06/log

NOTE:
The logs are the same as reported on other email reports.
link,
 - https://lore.kernel.org/stable/CA+G9fYu6ZOu_We2GMP0sFnSovOsqd6waW7oKS-Y1=
VPrjdibu5Q@mail.gmail.com/

## Build
* kernel: 4.19.283-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 373cdd8d6123d6ed489c5a5b91a0ab5b206ba0e4
* git describe: v4.19.282-192-g373cdd8d6123
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.282-192-g373cdd8d6123

## Test Regressions (compared to v4.19.279-173-g8ca3c8d28616)

* dragonboard-410c, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* dragonboard-410c, kselftest-rseq
  - rseq_basic_test

* dragonboard-410c, ltp-syscalls
  - fallocate06

* i386, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* i386, kselftest-rseq
  - rseq_basic_test
  - rseq_run_param_test_sh

* juno-r2, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* juno-r2, kselftest-rseq
  - rseq_basic_test

* juno-r2, ltp-syscalls
  - fallocate06

* juno-r2-compat, ltp-syscalls
  - fallocate06

* juno-r2-kasan, ltp-syscalls
  - fallocate06

* qemu_i386, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* qemu_i386, kselftest-rseq
  - rseq_basic_test
  - rseq_run_param_test_sh

* qemu_x86_64, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* qemu_x86_64, kselftest-rseq
  - rseq_basic_test

* x15, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* x15, kselftest-rseq
  - rseq_basic_test

* x86, kselftest-kvm
  - kvm_xapic_state_test

* x86, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* x86, kselftest-rseq
  - rseq_basic_test

## Metric Regressions (compared to v4.19.279-173-g8ca3c8d28616)

## Test Fixes (compared to v4.19.279-173-g8ca3c8d28616)

## Metric Fixes (compared to v4.19.279-173-g8ca3c8d28616)

## Test result summary
total: 80130, pass: 68396, fail: 2694, skip: 8901, xfail: 139

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 106 passed, 5 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

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
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
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
