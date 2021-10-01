Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC9C41E5F1
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 04:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351264AbhJACCd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Sep 2021 22:02:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59587 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230293AbhJACCc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Sep 2021 22:02:32 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19120huZ022087
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 22:00:44 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BD31515C34A8; Thu, 30 Sep 2021 22:00:43 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/5] libext2fs: Support for orphan file feature
Date:   Thu, 30 Sep 2021 22:00:42 -0400
Message-Id: <163305362417.207214.6959412974532288063.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210825221143.30705-1-jack@suse.cz>
References: <20210825220922.4157-1-jack@suse.cz> <20210825221143.30705-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 26 Aug 2021 00:11:30 +0200, Jan Kara wrote:
> Add support for creating and deleting orphan file and a couple of
> utility functions that will be used in other tools.
> 
> 

Applied, thanks!

[1/5] libext2fs: Support for orphan file feature
      commit: 1d551c68123c0e13259670991a099995031de0a1
[2/5] mke2fs: Add support for orphan_file feature
      commit: 818da4a904893f539e9e746f0f9378db626359ba
[3/5] e2fsck: Add support for handling orphan file
      commit: d0c52ffb0be829c7a5b42181ede1f5fbb1daf97e
[4/5] tune2fs: Add support for orphan_file feature
      commit: 795101dd0f7bd227a57332fef02a46fd4975011f
[5/5] dumpe2fs, debugfs, e2image: Add support for orphan file
      commit: a8f525888f608d6966e49637ed62c88887177532

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
