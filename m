Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7EF4455AB
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Nov 2021 15:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhKDOvJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Nov 2021 10:51:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33715 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229920AbhKDOvI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Nov 2021 10:51:08 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A4EmM2e018453
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 Nov 2021 10:48:23 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CB87215C00B9; Thu,  4 Nov 2021 10:48:22 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        kernel@collabora.com, adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: Fix error code saved on super block during file system abort
Date:   Thu,  4 Nov 2021 10:48:17 -0400
Message-Id: <163603728189.2753651.15455304955384700342.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211026173302.84000-1-krisman@collabora.com>
References: <20211026173302.84000-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 26 Oct 2021 14:33:02 -0300, Gabriel Krisman Bertazi wrote:
> ext4_abort will eventually call ext4_errno_to_code, which translates the
> errno to an EXT4_ERR specific error.  This means that ext4_abort expects
> an errno.  By using EXT4_ERR_ here, it gets misinterpreted (as an errno),
> and ends up saving EXT4_ERR_EBUSY on the superblock during an abort,
> which makes no sense.
> 
> ESHUTDOWN will get properly translated to EXT4_ERR_SHUTDOWN, so use that
> instead.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix error code saved on super block during file system abort
      commit: 124e7c61deb27d758df5ec0521c36cf08d417f7a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
