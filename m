Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02546575151
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbiGNPBN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 11:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiGNPBK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 11:01:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE35FAEF;
        Thu, 14 Jul 2022 08:01:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26EF0bXF011189
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 11:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657810839; bh=sFpZcIaOd7DnAF9OZCZNzBmIaZ7bPD9+z4NRwNzFCPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MqxNurxY2MEVlO28KsCu+VVgYMNnTJMYlxck3rxM1lkAqVxuas1JBdaKLSUqibSj6
         24ciFqCOr3VFmEJjTl75qrXS5ZMZVy7792fEJnq9HtAArg8CbRLC6blGuu5hmY60yj
         hU6A9MxUxdaGSuwhEXmvVv43ZxRcR2f86Jzf1svuDUyISY1NjesOF86QfrJOEBQT5+
         C7HWKRDJz/8fmyVujgDRjHzccdwz/pvx0bBVR0DYgZtP/9jezkqT5/3m/FrFgmg0Uj
         ZDZ/GxH23p5R3wwlh/JIxwTsHww6PfHJE7gp9qPwEAFj+VuWhy2dlHXbyiKcsXRB4n
         N4FkivbcsTn4g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 44D4515C003C; Thu, 14 Jul 2022 11:00:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, libaokun1@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, enwlinux@gmail.com,
        yebin10@huawei.com, lczerner@redhat.com, ritesh.list@gmail.com,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH v3 0/4] ext4: fix use-after-free in ext4_xattr_set_entry
Date:   Thu, 14 Jul 2022 11:00:34 -0400
Message-Id: <165781082373.2477554.10824721995094277212.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220616021358.2504451-1-libaokun1@huawei.com>
References: <20220616021358.2504451-1-libaokun1@huawei.com>
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

On Thu, 16 Jun 2022 10:13:54 +0800, Baokun Li wrote:
> This series adds a macro for whether there is space for xattr in
> ext4 inode, and fixes some problems with this macro.
> 
> V1->V2:
> 	Split the patch to make the logic clearer.
> 	Rename macro to EXT4_INODE_HAVE_XATTR_SPACE.
> V2->V3:
> 	Rename macro to EXT4_INODE_HAS_XATTR_SPACE.
> 
> [...]

Applied, thanks!

[1/4] ext4: add EXT4_INODE_HAS_XATTR_SPACE macro in xattr.h
      commit: ff528f6b155ce79adf38583a66867d8e54cbd460
[2/4] ext4: fix use-after-free in ext4_xattr_set_entry
      commit: 0847102f2b38b43f7352ed8a7f714a291ed1513d
[3/4] ext4: correct max_inline_xattr_value_size computing
      commit: 3d783a3751995003002a5f4f6d333c7c02c7966e
[4/4] ext4: correct the misjudgment in ext4_iget_extra_inode
      commit: 31c5d92b53629452d669980d17adbd22f2af0d26

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
