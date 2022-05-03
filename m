Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A639C517C52
	for <lists+linux-ext4@lfdr.de>; Tue,  3 May 2022 06:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiECEGX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 May 2022 00:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiECEGW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 May 2022 00:06:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1494337BC3
        for <linux-ext4@vger.kernel.org>; Mon,  2 May 2022 21:02:50 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24342loa021515
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 May 2022 00:02:47 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E730915C3EA1; Tue,  3 May 2022 00:02:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2fsck: no parent lookup in disconnected dir
Date:   Tue,  3 May 2022 00:02:45 -0400
Message-Id: <165155054451.879437.9981369991787776986.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211213063530.38352-1-adilger@whamcloud.com>
References: <20211213063530.38352-1-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, 12 Dec 2021 23:35:30 -0700, Andreas Dilger wrote:
> Don't call into ext2fs_get_pathname() to do a name lookup for a
> disconnected directory, since the directory block traversal in
> pass1 has already scanned all of the leaf blocks and never finds
> the entry, always printing "???".  If the name entry had been
> found earlier, the directory would not be disconnected in pass3.
> 
> Instead, lookup ".." and print the parent name in the prompt, and
> then do not search for the current directory name at all.  This
> avoids a useless full directory scan for each disconnected entry,
> which can potentially be slow if the parent directory is large.
> 
> [...]

Applied, thanks!

[1/1] e2fsck: no parent lookup in disconnected dir
      commit: 6b0e3bd7bd2f2db3c3993c5d91379ad55e60b51e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
