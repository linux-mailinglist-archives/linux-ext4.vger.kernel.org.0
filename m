Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F6D55023A
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 04:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbiFRC70 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 22:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383749AbiFRC7Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 22:59:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12226B03A
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 19:59:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25I2x63i024033
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 22:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655521148; bh=MbrL8CLUCG9oouyoWNmTsqAC8VOsteW+pwpglyvdlT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q1fByO2hM+ORiX0qj0222Q2OCnkxsGe8mnMQkwZk/p7lbd9NuyPDFdPo+XQ5PT8BY
         4/jDsqoFleKbje/zCBuwdcvhcpfKkpnW0nGkwWthUyjh8nxEe6sC9f7865r60ubWzo
         UKOo65RaC4b5kv0JfDw5RBE0kY/gN2G2fUtqN5Nqbn7s0cuqBMhWZYScthw506Si8/
         nDKC7NyzlLu60HpRNfi07ix29wzUre6Oitqyb6S8utU3oWlryKyrPd2A5T/BYlSLL1
         9/6HOKZY62PV7EkmBMHCMKWMLKYbxvvnOU5LgLxasNsNtObGI1UoFw5OqKWE5qhrCE
         Ws3fGsQOmO7zw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4D13A15C430A; Fri, 17 Jun 2022 22:59:06 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, ritesh.list@gmail.com,
        yukuai3@huawei.com, jack@suse.cz, adilger.kernel@dilger.ca
Subject: Re: [PATCH v2] ext4: add reserved GDT blocks check
Date:   Fri, 17 Jun 2022 22:59:03 -0400
Message-Id: <165552108974.634564.9535249162879745739.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220601092717.763694-1-yi.zhang@huawei.com>
References: <20220601092717.763694-1-yi.zhang@huawei.com>
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

On Wed, 1 Jun 2022 17:27:17 +0800, Zhang Yi wrote:
> We capture a NULL pointer issue when resizing a corrupt ext4 image which
> is freshly clear resize_inode feature (not run e2fsck). It could be
> simply reproduced by following steps. The problem is because of the
> resize_inode feature was cleared, and it will convert the filesystem to
> meta_bg mode in ext4_resize_fs(), but the es->s_reserved_gdt_blocks was
> not reduced to zero, so could we mistakenly call reserve_backup_gdb()
> and passing an uninitialized resize_inode to it when adding new group
> descriptors.
> 
> [...]

Applied, thanks!

[1/1] ext4: add reserved GDT blocks check
      commit: 7dc0ff3a33ea92cefaf032a6d0de9314a9a5fb20

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
