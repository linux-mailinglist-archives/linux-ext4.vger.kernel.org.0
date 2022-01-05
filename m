Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864C3484CBF
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 04:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiAEDOr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 22:14:47 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45762 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232991AbiAEDOr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 22:14:47 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2053EfaT001139
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jan 2022 22:14:42 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7326215C33AD; Tue,  4 Jan 2022 22:14:41 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger@dilger.ca
Subject: Re: [PATCH v5] ext4: implement support for get/set fs label
Date:   Tue,  4 Jan 2022 22:14:39 -0500
Message-Id: <164135246476.257673.2713595521546345727.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211213135618.43303-1-lczerner@redhat.com>
References: <20211210184808.37071-1-lczerner@redhat.com> <20211213135618.43303-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 13 Dec 2021 14:56:18 +0100, Lukas Czerner wrote:
> Implement support for FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls for
> online reading and setting of file system label.
> 
> ext4_ioctl_getlabel() is simple, just get the label from the primary
> superblock. This might not be the first sb on the file system if
> 'sb=' mount option is used.
> 
> [...]

Applied, thanks!

[1/1] ext4: implement support for get/set fs label
      commit: 37d1c2c49c13f7a34900a7d3e479326a7bb32364

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
