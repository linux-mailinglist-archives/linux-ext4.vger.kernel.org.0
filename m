Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5895C716D7D
	for <lists+linux-ext4@lfdr.de>; Tue, 30 May 2023 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjE3T0n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 May 2023 15:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjE3T0m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 May 2023 15:26:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C72F102
        for <linux-ext4@vger.kernel.org>; Tue, 30 May 2023 12:26:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34UJQcIx011213
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 15:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685474799; bh=LP4GTc9jo1xC/A6a3LF3hy2V4U/4KugGDFq8dckbZ28=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=I7i3o5mMbHrjj1CKC9bo7xMC/n9pCL4NuU7q0btEPJ3ud31bhVVqR29ozAOh5fkTP
         w3+ceQJzW8+iGBCuckUYTxcDXyqFdBgfuinyvdO6kPEzYczpVoXY4TK3pOnxi0Of06
         jpMlBhswXZeK+ICSddWS0h2LoRYkFWgmNIMDKnK7z3KmyhBlnqBu8UyN7mJF3t+o6x
         Dq16d344mf/SULLkkIPpC7W0pR6evKwwHLZmwwUnCRTGr497YNobP//QWzKvxDTt5L
         RfHuiIY3aK0OwHfl3tMmK5xyDTKYWvrywRqcQbdTI4WJyLhSEXboIIYRM5kflj0WYG
         LO2KfCzO+tzrA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DF72815C04AF; Tue, 30 May 2023 15:26:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: enable the lazy init thread when remounting read/write
Date:   Tue, 30 May 2023 15:26:36 -0400
Message-Id: <168547476046.200310.7041705947856028358.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230527035729.1001605-1-tytso@mit.edu>
References: <ZGPDX3pMMa3yg4yg@debian-BULLSEYE-live-builder-AMD64> <20230527035729.1001605-1-tytso@mit.edu>
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


On Fri, 26 May 2023 23:57:29 -0400, Theodore Ts'o wrote:
> In commit a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting
> r/w until quota is re-enabled") we defer clearing tyhe SB_RDONLY flag
> in struct super.  However, we didn't defer when we checked sb_rdonly()
> to determine the lazy itable init thread should be enabled, with the
> next result that the lazy inode table initialization would not be
> properly started.  This can cause generic/231 to fail in ext4's
> nojournal mode.
> 
> [...]

Applied, thanks!

[1/1] ext4: enable the lazy init thread when remounting read/write
      commit: 781c858c35c821f7055ccca73d27b6d1c77798b3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
