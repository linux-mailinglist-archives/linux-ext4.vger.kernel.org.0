Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79891484CC1
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 04:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiAEDOt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 22:14:49 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45772 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234515AbiAEDOt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 22:14:49 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2053Ef15001134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jan 2022 22:14:42 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6691E15C00E1; Tue,  4 Jan 2022 22:14:41 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid trim error on fs with small groups
Date:   Tue,  4 Jan 2022 22:14:36 -0500
Message-Id: <164135246476.257673.18374747677460683644.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211112152202.26614-1-jack@suse.cz>
References: <20211112152202.26614-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 12 Nov 2021 16:22:02 +0100, Jan Kara wrote:
> A user reported FITRIM ioctl failing for him on ext4 on some devices
> without apparent reason.  After some debugging we've found out that
> these devices (being LVM volumes) report rather large discard
> granularity of 42MB and the filesystem had 1k blocksize and thus group
> size of 8MB. Because ext4 FITRIM implementation puts discard
> granularity into minlen, ext4_trim_fs() declared the trim request as
> invalid. However just silently doing nothing seems to be a more
> appropriate reaction to such combination of parameters since user did
> not specify anything wrong.
> 
> [...]

Applied, thanks!

[1/1] ext4: Avoid trim error on fs with small groups
      commit: a4934e25c01ed056dc4af8bef086616e3b083a14

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
