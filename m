Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD28070146D
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 07:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjEME7y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 00:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjEME7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 00:59:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB99448C
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 21:59:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34D4xXOj020076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 00:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683953975; bh=dP8cUmedl4/qxac+pn4Gmr1fHv5/w3A4ypuxRSa09v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ign/OTlDg/eOdNLiiIPrHOozMbyf+JexbhrBBVMi+z78LIqDoKtDedOhethKYD5Fp
         yV5PsAlUVaEEgyJ/fO17Y9Is9LnjIIQ7CNWPU3FsOputshM/fCs7b7fIMSEw8TzHtG
         CWD4ZtdoW4sRVt1ZnS2lz1kIf2C7uVmoorgMJTLNyYe3uUmcIp8bg06M86BhMy3K4M
         6jU5gifWdBV4W0V9/s/rgKrF9HtVxl9Z9YixRuH9JqRvmDPhUQRF4hvMPwhx6leJ1/
         jhjy3DPc1BVlU1+9mmJ6uB+78eTrIFn4p1tisjdRFd/pH/BC0avLc9OtVyFFx3q+Sg
         pOyeK4ZRemitQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 744A815C02E7; Sat, 13 May 2023 00:59:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        syzbot+aacb82fca60873422114@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix lockdep warning when enabling MMP
Date:   Sat, 13 May 2023 00:59:28 -0400
Message-Id: <168395396128.1443054.13940837195861107555.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230411121019.21940-1-jack@suse.cz>
References: <20230411121019.21940-1-jack@suse.cz>
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


On Tue, 11 Apr 2023 14:10:19 +0200, Jan Kara wrote:
> When we enable MMP in ext4_multi_mount_protect() during mount or
> remount, we end up calling sb_start_write() from write_mmp_block(). This
> triggers lockdep warning because freeze protection ranks above s_umount
> semaphore we are holding during mount / remount. The problem is harmless
> because we are guaranteed the filesystem is not frozen during mount /
> remount but still let's fix the warning by not grabbing freeze
> protection from ext4_multi_mount_protect().
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix lockdep warning when enabling MMP
      commit: 949f95ff39bf188e594e7ecd8e29b82eb108f5bf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
