Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32E56B0EF
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 05:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiGHDUK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 23:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiGHDUI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 23:20:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB42B747AF
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 20:20:07 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2683JxLi032627
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 23:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657250400; bh=rzM4JnxsppqSM2vHb/02UyqEjs93rR0k/9uY2TW0qNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FlJ+pig0ztsXDGLLAgxrI2vMUvEW/pnh98QbdZsW/IGok5aZbN3pw20phU+Pw4qBy
         qQugrNrQZk6g+pi+OLrTSM+x5MScoPiqBtF7sfb7J2VqpgYkuzfcEvqSCyUS77adT0
         svgXmr+8j5hmhcx6CWY/FCsFuITN3gG6+PXZi2Q8t2FOQNLIsBRwitAVj2KbRj0uRw
         vQcyGmk8DBRY9cflEoIHrFzJZjGg+D5Yxf+uKlx9QFueqORH6xgl64jdk6AzBEAMIN
         SS2JYgTVIElFNJGFjsSzPyECHbZ5uXTcQlRngwMcfAMTnT5MB33hMSRG4TQ6F099+g
         4v2OuHUz2XdeQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8B25015C4341; Thu,  7 Jul 2022 23:19:59 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     stable@kernel.org
Subject: Re: [PATCH 1/2] ext4: update s_overhead_clusters in the superblock during an on-line resize
Date:   Thu,  7 Jul 2022 23:19:56 -0400
Message-Id: <165725003055.1812964.10089302372877257908.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220629040026.112371-1-tytso@mit.edu>
References: <20220629040026.112371-1-tytso@mit.edu>
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

On Wed, 29 Jun 2022 00:00:25 -0400, Theodore Ts'o wrote:
> When doing an online resize, the on-disk superblock on-disk wasn't
> updated.  This means that when the file system is unmounted and
> remounted, and the on-disk overhead value is non-zero, this would
> result in the results of statfs(2) to be incorrect.
> 
> This was partially fixed by Commits 10b01ee92df5 ("ext4: fix overhead
> calculation to account for the reserved gdt blocks"), 85d825dbf489
> ("ext4: force overhead calculation if the s_overhead_cluster makes no
> sense"), and eb7054212eac ("ext4: update the cached overhead value in
> the superblock").
> 
> [...]

Applied, thanks!

[1/2] ext4: update s_overhead_clusters in the superblock during an on-line resize
      commit: e781b8ce9261f353df91b94303e53c31fdf9871e
[2/2] ext4: update the s_overhead_clusters in the backup sb's when resizing
      commit: 2c8204b83ceaf439dff2d1a94a7e2d3ad7619287

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
