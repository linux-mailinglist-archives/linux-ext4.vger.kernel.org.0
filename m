Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBE354FB2D
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jun 2022 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383346AbiFQQdc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 12:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383358AbiFQQda (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 12:33:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4525447AFE
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 09:33:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l18so5267037lje.13
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=4ovR8XEIiThxafmbfH2hWCxDryiss6gUb37WNfn5iMk=;
        b=IdLBhIMFwPrPNyC39302QDb+j6uj4tv5MsJwL3qEccuNNHDa19VAcNv/VfyIm8pZwC
         iqVYfJReYyD0ucIbq7cMU/9VZZ5Z9rxVvGtHrRnm1nd8Ugo8URr/csb/rY6eVAApBVpl
         AZ6n0AXg+qIJQyobxeICo/0+ZuPSYnNKtBmvr9L2M0w21SKFZ+ah3b1NsiP1caFVPRz2
         tCBKBNZHUezinaoAvEAj+eY9LQfP9s/zlpbETGGLoOZV0eeDs42saSnfgm4g6e+idhRW
         Io9y+/nD+VItDGvBWkElT62mCq8PRlVXn5GNwcqk5c4QaHE4gMWOdUr4AdluvtxiZ+nB
         LQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4ovR8XEIiThxafmbfH2hWCxDryiss6gUb37WNfn5iMk=;
        b=GbOiaU/8UDexPZfNDo+Q/84OFoDNsbj7LL6ajTE2Vkhpi6l9CVOBrjMRXyeZyC1AR7
         rJj6ZswWiiJJRogvS0OIISfF+6DQqsddErLcPu59Nncpfw1s2KgOGWGJ3T1RAlcVE2ch
         3KWPuxA/ECvOR/9UzDrIvDca8j8Ua+QVp9LInbcQ+mRiB+rUgbblr8Hv5f3We+niMRC2
         ZBbnWV+P6xtXtRXlRl2h9dbDUxg9MW7U7Cog0lB81JClSYo+r5RVu4duUmPHES48Rv3U
         xERlArFJZO0xA4OuqutDzZof/vSQKYdD/YCzVqitt+aq363NWiowHzzZ5PTZ419Jh0an
         j4yw==
X-Gm-Message-State: AJIora/46slOMEm17/mh8cnCHXmYHvCC7G2WZwgsGtW5Qdpiz4sDsQh0
        oz9n5KZ+FSNpKdwBHEuXGCHLsDC5PTMalNlm0UYorKL67Auusg==
X-Google-Smtp-Source: AGRyM1sYavaP36kbfhhvZzmFTX54+WdtKo/jEsD3jhlowfsX3hkVqm85Z0suxNkTnEXPfXCeNzsc93ZwY/5GMYScy00=
X-Received: by 2002:a2e:b893:0:b0:255:c257:5de with SMTP id
 r19-20020a2eb893000000b00255c25705demr5617180ljp.53.1655483606349; Fri, 17
 Jun 2022 09:33:26 -0700 (PDT)
MIME-Version: 1.0
From:   Santosh S <santosh.letterz@gmail.com>
Date:   Fri, 17 Jun 2022 12:33:15 -0400
Message-ID: <CAGQ4T_L9B7RMUc=aE_x4zFXVdg1OOWsiz_5+NfvNFD5jXxJQfA@mail.gmail.com>
Subject: santosh.letterz@gmail.com
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
