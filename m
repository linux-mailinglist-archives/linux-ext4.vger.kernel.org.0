Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59EC69BEA3
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 06:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBSFl2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 00:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBSFl1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 00:41:27 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0913D4C
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 21:41:22 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J5evIg024876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 00:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676785260; bh=casH54JtW/otMH7sj7fBvGYiaTIafQTckJf0Umd3EPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QC5edBPTCn1iCizX0crRRvtxqyBvPyakApt/+J7ECVjEAh8kYC2LJvc9TFX6kMUIG
         eQrA0UZ2V24OzuApaPmc0ElZkIvgGvg+FAmAVK68YJvjYKGl4apcsue/J/NBY5vAYi
         36lsdflVuuvNamMlrF+BXD3K60eTbwDBN1IOIh4a/wodQ4fMKfZTsUfyVqLtffe1GM
         rpfiYe2g52ak+TeH+wgyFD5oLaeVOIfdWe3qyA7gTzWzsXD4LxEecE8O3zdD1KlMz3
         MPK1VvZBAuzPH6WFV4GLsh+gzPnWTYV8DOBtzQRwfqtRMSAESu5rB5PiisuXaXP3L+
         ReKUI6nYEr5Zg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CB41915C35A8; Sun, 19 Feb 2023 00:40:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yukuai3@huawei.com, jack@suse.cz,
        ritesh.list@gmail.com, adilger.kernel@dilger.ca,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ext4: fix possible null pointer dereference in ext4_get_group_info
Date:   Sun, 19 Feb 2023 00:40:48 -0500
Message-Id: <167678522171.2723470.10131660626461360692.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230107032126.4165860-1-libaokun1@huawei.com>
References: <20230107032126.4165860-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 7 Jan 2023 11:21:24 +0800, Baokun Li wrote:
> V1->V2:
> 	In PATCH 1/2, -EFSCORRUPTED instead of -ESTALE is returned for
> 	special inode errors, and extra parentheses are removed.
> 
> Baokun Li (2):
>   ext4: fail ext4_iget if special inode unallocated
>   ext4: update s_journal_inum if it changes after journal replay
> 
> [...]

Applied, thanks!

[1/2] ext4: fail ext4_iget if special inode unallocated
      commit: 5cd740287ae5e3f9d1c46f5bfe8778972fd6d3fe
[2/2] ext4: update s_journal_inum if it changes after journal replay
      commit: 3039d8b8692408438a618fac2776b629852663c3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
