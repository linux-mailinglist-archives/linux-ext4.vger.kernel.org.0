Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D32485FF4
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 05:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiAFEmE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 23:42:04 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39523 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233915AbiAFEmD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 23:42:03 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2064ftL7003554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 23:41:55 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 18A1A15C33AF; Wed,  5 Jan 2022 23:41:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to extents
Date:   Wed,  5 Jan 2022 23:41:53 -0500
Message-Id: <164144408579.468293.3012506216318605150.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211214175058.19511-1-lhenriques@suse.de>
References: <20211214175058.19511-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 14 Dec 2021 17:50:58 +0000, Luís Henriques wrote:
> When migrating to extents, the temporary inode will have it's own checksum
> seed.  This means that, when swapping the inodes data, the inode checksums
> will be incorrect.
> 
> This can be fixed by recalculating the extents checksums again.  Or simply
> by copying the seed into the temporary inode.
> 
> [...]

Applied, thanks!

[1/1] ext4: set csum seed in tmp inode while migrating to extents
      commit: 304f3f7a2817c03a05efabd6d4ae3f5e85b0da73

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
