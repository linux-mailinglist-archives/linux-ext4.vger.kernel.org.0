Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A769BE9D
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 06:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBSFlJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 00:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBSFlH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 00:41:07 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF76E13514
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 21:41:02 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J5etIs024824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 00:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676785257; bh=rgVuDUomE0ejJJ/GLuDkeFwP61HFDzTuUTXOf2MsRN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QS38Iq2ZOMZ/kp/biRPkFmaEJH/bWRbgPEMgCLIiDPc1jasDR0xvtdAw81ka6a72y
         zZgAVVzAMGtZNRzjLaCUOt9iZu2VIKXlXt524UkIbsRqh8T9mXRhkuVltglr712hk1
         /YL3sMZObkVZ8rILmM/UgSBabWs9Gqd3CCzHZi4ndpVGv647tHyjtjEOt4uUI7AyfT
         HrWJ6dysUEn4UX0FosPCJr5+z3L2ezj03UOIJ9f0WQ62i0F/aS/9849FmnL4wY3QUE
         C8bGBhvxOAu3l9RsEvEmiK+Zo7tppRhdPEa7OcNRZer8V8GhmjwBsu/O+VMNJ4y5jo
         47HK1j+eqOCJQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C3CF215C35A4; Sun, 19 Feb 2023 00:40:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/7] ext4: Cleanup data=journal writeback path
Date:   Sun, 19 Feb 2023 00:40:44 -0500
Message-Id: <167678522161.2723470.8525900345936295049.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230111152736.9608-1-jack@suse.cz>
References: <20230111152736.9608-1-jack@suse.cz>
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

On Wed, 11 Jan 2023 16:43:24 +0100, Jan Kara wrote:
> this patch series implements promised cleanup of ext4 data=journal writeback
> path. That way we can get rid of last remnants of old support for .writepage
> callback and mostly unify this writeback path with standard data handling
> modes. We also update some of the stale comments regarding data=journal mode
> along the way.
> 
> Note that patch 3 (ext4: Mark page for delayed dirtying only if it is pinned)
> currently breaks somewhat the data=journal guarantees if mapped page cache is
> used as a buffer for direct IO read because that path does not pin pages yet
> (David Howels is working on it). But I figured this is not a huge deal for a
> cornercase usecase of a cornercase configuration and keeping marking page for
> delayed dirtying unconditionally is problematic as checkpointing dirties the
> page as well so it is effectively permanently added to the journal. It was
> problematic already in the past and happened to work only by luck.
> 
> [...]

Applied, thanks!

[1/7] ext4: Update stale comment about write constraints
      commit: d399906a1bd04c3fbc5bca9057ce992dc9b9e036
[2/7] ext4: Use nr_to_write directly in mpage_prepare_extent_to_map()
      commit: 726432969963b16f817566715b0c7ec537d0283b
[3/7] ext4: Mark page for delayed dirtying only if it is pinned
      commit: 71ace6bd0d47b09d6130014d70f87fcff5ae3e36
[4/7] ext4: Don't unlock page in ext4_bio_write_page()
      commit: 0bcd54cf93e0dcefd121368fa32a478df2c86398
[5/7] ext4: Move page unlocking out of mpage_submit_page()
      commit: 9ff6a9153c8f8a08eb60e0740c32e08cef88545c
[6/7] ext4: Move mpage_page_done() calls after error handling
      commit: b4d26e70a7556ca723d31ac0c6bace0d1ab932b5
[7/7] ext4: Convert data=journal writeback to use ext4_writepages()
      commit: 9b18c23c131ae6a335ef7aa6bf53f1d27a667ed1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
