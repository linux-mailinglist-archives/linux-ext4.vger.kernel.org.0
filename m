Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B38754FB3A
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jun 2022 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383343AbiFQQii (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383351AbiFQQie (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 12:38:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6683338BC1
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 09:38:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s6so7712998lfo.13
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=4ovR8XEIiThxafmbfH2hWCxDryiss6gUb37WNfn5iMk=;
        b=gYU6RrB32s5kXlmT0sUS2HQxRdRvqh0q2c4cEvRfiMhDv4WPp4zQcgB/yZYxSnIsuQ
         5+BU+w4Q/qBqRtc1IXhJaOcpdTWB7ioPoc1Gs0hwCCm7p1d5ewDvS5/iFo/d/IWoPEhP
         kIaBgHlYgblxaKezH3Imu7wrMdCWvUD1E177cojN+UrxRkPFX1XaCBGaP7qmjFkGW8Rp
         gH1A6BtLjL5DWzSDq7BWjUoDnM3QvFSPheVYoVMIo7D31dnsWHkPrMHSWvoKfKmpuVH1
         kC/ymjGD+DYl3PJuBRFCNNGoLCeJ4eBY7aoemNDNqkwbC7IOaP/gd7Cs1o8SH3yAway5
         cdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4ovR8XEIiThxafmbfH2hWCxDryiss6gUb37WNfn5iMk=;
        b=6nKQhQ2zR3oLDZsfMO8cYP6TelZrbTeQ6/ZClawR71HdIf1VAgEVTgZJW6IGDtOnWA
         lENDjL2EdeImh2VniobUK71IdMQQOr6JszP3F3M7sp4GU8Ckx6o9sfgSJrPnUmFHJTPH
         NeV9vUp0gb4t4syDhpn5t3FEWsO0qfTwyPGVWWXDHXEHle9zICi2HMLjfttG2Xj5SgII
         OMettIuP3fbrHgVTCPRbWHAUBhhRR+O6PtF5XVmW74leib4zSqBYuYOTCEzz+j76Z3NK
         P2IyiKGudR44adc4BywIyvdHjPdjvusIQfJzwYW8DxVxFLn+UQn4SU4c6fB3+c42yeCU
         SCmA==
X-Gm-Message-State: AJIora+HmEV3SnHYsnixH7TuG/LyWlVv274Z5qhbZav3wUt6DlxsIBPb
        iVwriaacrj6rGXrySml4OEvNlB/CtL+PSBxiztuMrjYNXTcG/ndD
X-Google-Smtp-Source: AGRyM1uosIvbc1rjcjhfQvRSKQWI8rG+SQIDdFRfLfVMyRcMCx7wgdVirPoHWSKvJ1BzOBQyd6oJiwfjTOKLCMEEd5Y=
X-Received: by 2002:a05:6512:2346:b0:479:43b1:8fcf with SMTP id
 p6-20020a056512234600b0047943b18fcfmr5959490lfu.441.1655483911493; Fri, 17
 Jun 2022 09:38:31 -0700 (PDT)
MIME-Version: 1.0
From:   Santosh S <santosh.letterz@gmail.com>
Date:   Fri, 17 Jun 2022 12:38:20 -0400
Message-ID: <CAGQ4T_Jne-bxdP9rMNBzqXw16a4kD4FM=F5VuGgUbczj5WgCLA@mail.gmail.com>
Subject: Overwrite faster than fallocate
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear ext4 developers,

This is my test - preallocate a large file (2G) and then do sequential
4K direct-io writes to that file, with fdatasync after every write.
I am preallocating using fallocate mode 0. I noticed that if the 2G
file is pre-written rather than fallocate'd I get more than twice the
throughput. I could reproduce this with fio. The storage is nvme.
Kernel version is 5.3.18 on Suse.

1. Clear the location
# rm -rf /mnt/nvme1n1/*

2. Run fio using fallocate
# taskset -c 0 ./fio -directory=/mnt/nvme1n1 -ioengine=io_uring
-fdatasync=1 -direct=1 -rw=write -iodepth=128 -iodepth_batch=64
-iodepth_batch_complete=64 -fallocate=native -bs=4k -size=2G -thread=1
-time_based=0 -numjobs=1 -group_reporting -output=fio.out
-name=fiotest

3. Results
write: IOPS=188k, BW=732MiB/s (768MB/s)(2048MiB/2796msec)

4. Run the same test again, this time the file already exists from the
previous run.
write: IOPS=420k, BW=1640MiB/s (1719MB/s)(2048MiB/1249msec)

It doesn't matter if I pass -fallocate to fio or not in step 4.

When I run ftrace (and if I am understanding the o/p correctly) I see
that in the first run ext4_convert_unwritten_extents() seems to be
taking a lot of time. This call is not present in the second run.

 110)  <...>-11449   | # 1102.026 us |      } /*
ext4_convert_unwritten_extents [ext4] */
 110)  <...>-11449   |   0.117 us    |      ext4_release_io_end [ext4]();
 110)  <...>-11449   | # 1102.421 us |    } /* ext4_put_io_end [ext4] */
 110)  <...>-11449   | # 1102.599 us |  } /* ext4_end_io_dio [ext4] */

Am I doing something wrong or is this difference expected? Any
suggestion to get a better throughput without actually pre-writing the
file.

Thank you for your time,
Santosh
