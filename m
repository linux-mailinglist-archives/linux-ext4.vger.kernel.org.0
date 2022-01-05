Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85A484CBE
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 04:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiAEDOp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 22:14:45 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45756 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232991AbiAEDOp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 22:14:45 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2053EfgE001137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jan 2022 22:14:42 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6E50315C339C; Tue,  4 Jan 2022 22:14:41 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] tune2fs: implement support for set/get label iocts
Date:   Tue,  4 Jan 2022 22:14:38 -0500
Message-Id: <164135246476.257673.7909016051692908317.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211124134542.22270-1-lczerner@redhat.com>
References: <20211124134542.22270-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 24 Nov 2021 14:45:42 +0100, Lukas Czerner wrote:
> Implement support for FS_IOC_SETFSLABEL and FS_IOC_GETFSLABEL ioctls.
> Try to use the ioctls if possible even before we open the file system
> since we don't need it. Only fall back to the old method in the case the
> file system is not mounted, is mounted read only in the set label case,
> or the ioctls are not suppported by the kernel.
> 
> The new ioctls can also be supported by file system drivers other than
> ext4. As a result tune2fs and e2label will work for those file systems
> as well as long as the file system is mounted. Note that we still truncate
> the label exceeds the supported lenghth on extN file system family, while
> we keep the label intact for others.
> 
> [...]

Applied, thanks!

[1/1] tune2fs: implement support for set/get label iocts
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
