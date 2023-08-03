Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E0776ECD2
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjHCOjM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbjHCOi5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 10:38:57 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2174012C
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 07:37:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 373Eb5GH009285
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 10:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691073427; bh=uzPcTGdH2zmyx5RhT85/uwzQLy+Lgw2CJzu/jWqGUEo=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=X77FYlLe/HcR6kNKG7shDQEqvRrpE+HiEyEunbs91BS7JFzPaqDp/TIGzR4rr31nS
         LXSmEsVXTi3DBQeq8UrcezZ0/6XzUmhE5iEIclbHxvyGtu9sihpoHfBXez6mVA3C4q
         v5QG3Kn1jGANCZyWT84ofiYkufMRz8bTDZPvptT9U55oCXucLaVQwrcSwUIsYDRnS9
         alC/x24Earf8PZ0tpQFLDq+++SztTD5NFsnw0x0WkOSa5/+XA0DRKIA/+2jxRpo3Al
         7XqEJEcMmwkCLYHWLEDNZYDsny0CXNsSvLZRw4IsQ6TBGQKTqraXmo3sLOlrP5x32E
         E7ESBZ+zhrF8A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AC89F15C04F1; Thu,  3 Aug 2023 10:37:05 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/11] ext4: Cleanup read-only and fs aborted checks
Date:   Thu,  3 Aug 2023 10:37:01 -0400
Message-Id: <169107341682.1086009.5390893702477027431.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Fri, 16 Jun 2023 18:50:46 +0200, Jan Kara wrote:
> This series arised from me trying to fix races when the ext4 filesystem gets
> remounted read-write and users can race in writes before quota subsystem is
> prepared to take them. This particular problem got fixed in VFS in the end
> but the cleanups are still good in my opinion so I'm submitting them. They
> get rid of EXT4_MF_ABORTED flag and cleanup some sb_rdonly() checks.
> 
> Honza
> 
> [...]

Applied, thanks!

[01/11] ext4: Remove pointless sb_rdonly() checks from freezing code
        commit: 98175720c9ed3bac857b0364321517cc2d695a3f
[02/11] ext4: Use sb_rdonly() helper for checking read-only flag
        commit: d5d020b3294b69eaf3b8985e7a37ba237849c390
[03/11] ext4: Make ext4_forced_shutdown() take struct super_block
        commit: eb8ab4443aec5ffe923a471b337568a8158cd32b
[04/11] ext4: Make 'abort' mount option handling standard
        commit: 22b8d707b07e6e06f50fe1d9ca8756e1f894eb0d
[05/11] ext4: Drop EXT4_MF_FS_ABORTED flag
        commit: 95257987a6387f02970eda707e55a06cce734e18
[06/11] ext4: Avoid starting transaction on read-only fs in ext4_quota_off()
        commit: e0e985f3f8941438a66ab8abb94cb011b9fb39a7
[07/11] ext4: Warn on read-only filesystem in ext4_journal_check_start()
        commit: e7fc2b31e04c46c9e2098bba710c9951c6b968af
[08/11] ext4: Drop read-only check in ext4_init_inode_table()
        commit: ffb6844e28ef6b9d76bee378774d7afbc3db6da9
[09/11] ext4: Drop read-only check in ext4_write_inode()
        commit: f1128084b40e520bea8bb32b3ff4d03745ab7e64
[10/11] ext4: Drop read-only check from ext4_force_commit()
        commit: 889860e452d7436ca72018b8a03cbd89c38d6384
[11/11] ext4: Replace read-only check for shutdown check in mmp code
        commit: 1e1566b9c85fbd6150657ea17f50fd42b9166d31

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
