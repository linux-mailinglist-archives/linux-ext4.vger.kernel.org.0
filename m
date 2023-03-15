Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E826BB966
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 17:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjCOQRS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjCOQQu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 12:16:50 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A470B2694
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 09:16:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32FGGFkn006780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 12:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678896976; bh=zQ/Hu9kJeReFnLn4i3pu0oXpLUgSddHUxRvffa4cIGc=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=DnVBhTGCwb89enN+k6YMjp/PVYmLv2NjR5NGFhK56rwwoxUlFbDhxACHZjU1tnnYv
         9poWf4jtI4vgErY6G3A1Gco53d2XfCeWdPAEcvExaxLCdDsaMK8+DGQFAlxNVxOxmS
         5z+QTu/oyeiCxFZL3vyidi9zH24MgMdchTlH6ByONCn8PDlRevPboUda83Zi26vGzy
         wBluRzy/JhrAkpe77c2S2NY5+imTQ5QkYDWgzIAQEyULYStX4fiGiq7HAjjDgrjsgU
         oN8WeEyNtC4N5HCv2rVjjAK/3XZZZbOhX0O/r190xUmqOVefBBPz64UBUJ5VDWN9Gk
         aij5loO1+Y7Vg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 90B8715C5831; Wed, 15 Mar 2023 12:16:15 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH REBASED 0/7] ext4: Cleanup data=journal writeback path
Date:   Wed, 15 Mar 2023 12:16:12 -0400
Message-Id: <167889696171.3024151.6524579261091560528.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230228051319.4085470-1-tytso@mit.edu>
References: <20230228051319.4085470-1-tytso@mit.edu>
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

On Tue, 28 Feb 2023 00:13:12 -0500, Theodore Ts'o wrote:
> This is Jan's data=journal cleanup patch series, previously submitted
> here[1] rebased on top of Linus's patches to address merge conflicts
> with mm-stable, per this discussion[2].
> 
> [1] https://lore.kernel.org/r/20230111152736.9608-1-jack@suse.cz
> [2] https://lore.kernel.org/r/Y/k4Jvph15ugcY54@mit.edu
> 
> [...]

Applied, thanks!

[1/7] ext4: Update stale comment about write constraints
      commit: e7a2d7ab32fd5bfe431d69df56eedf74c747dfa1
[2/7] ext4: Use nr_to_write directly in mpage_prepare_extent_to_map()
      commit: 6e6213b505709902199d69f56f64bba3dbd867ff
[3/7] ext4: Mark page for delayed dirtying only if it is pinned
      commit: 90f1929e5e5af0467572c81e6ac78ae20316f439
[4/7] ext4: Don't unlock page in ext4_bio_write_page()
      commit: 2c892bdd69ce89e534c915e84c3e4ba98de9ef6c
[5/7] ext4: Move page unlocking out of mpage_submit_page()
      commit: 22e00e971f55a0b7b375d937db614863e1a2e500
[6/7] ext4: Move mpage_page_done() calls after error handling
      commit: 47c6f573b4ef9bf68ce45bd4e4c35ef56d326fe1
[7/7] ext4: Convert data=journal writeback to use ext4_writepages()
      commit: f7233fb54d18b45b42d8f6ad6a95bd8641114c36

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
