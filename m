Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C4A5501E5
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 04:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383846AbiFRCMe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 22:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383832AbiFRCMb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 22:12:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886446A433;
        Fri, 17 Jun 2022 19:12:30 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25I2CDcb005814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 22:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655518336; bh=fA9Nh40pF/DajZdlaGKfbAy9Rz4KtL1exScJPOKvYDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pZ1fu/YQppjav1jy/hSMgcfqGdrgMW5GCmcCBHKga1g1IETZ+5+DwW0SFmt/gX4S0
         VFWo6JTZxkGNglxyHEZDXVv1b3k9z20Sr8AnNJ9xwgwh6qdyJL67QCA9rl3hf8iwY6
         a1DwZkRO79OeYE6c61mMpROeqa1j4fER+3szL5MM21zYOGtV/R7n+5VRb2VNTtB/F9
         UTbAG1FXpPBfsY8+YEEaf30VXccE5IhuASZNtS3q0fyFB58AGg9rizdMJxQi+lOD9o
         AMvA3B0zxvkmcKeD6xGCHtwdCA6b64FTX42B2/GYERzJ4PU3eUqRmOjYcTxTIw+IVW
         7f/Xqlj1SHo0w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B8ABF15C430B; Fri, 17 Jun 2022 22:12:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: fix super block checksum incorrect after mount
Date:   Fri, 17 Jun 2022 22:12:07 -0400
Message-Id: <165551818832.612215.7676699099874153095.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220525012904.1604737-1-yebin10@huawei.com>
References: <20220525012904.1604737-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 25 May 2022 09:29:04 +0800, Ye Bin wrote:
> We got issue as follows:
> [home]# mount  /dev/sda  test
> EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
> [home]# dmesg
> EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
> EXT4-fs (sda): Errors on filesystem, clearing orphan list.
> EXT4-fs (sda): recovery complete
> EXT4-fs (sda): mounted filesystem with ordered data mode. Quota mode: none.
> [home]# debugfs /dev/sda
> debugfs 1.46.5 (30-Dec-2021)
> Checksum errors in superblock!  Retrying...
> 
> [...]

Applied, thanks!

[1/1] ext4: fix super block checksum incorrect after mount
      commit: 17217902fc4fcba1d143e59b308fa7de4c372f50

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
