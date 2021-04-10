Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E035AA7E
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Apr 2021 05:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhDJDUC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 23:20:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59884 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234160AbhDJDUB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 23:20:01 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13A3Jdm8010769
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 23:19:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E426615C3B12; Fri,  9 Apr 2021 23:19:38 -0400 (EDT)
Date:   Fri, 9 Apr 2021 23:19:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] EXT4: Trivial typo fixes
Message-ID: <YHEZSoZ5Lt8+LXMz@mit.edu>
References: <cover.1616840203.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616840203.git.unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 27, 2021 at 04:00:04PM +0530, Bhaskar Chowdhury wrote:
> This patch series fixed few mundane typos in the below specific files.
> 
> Bhaskar Chowdhury (8):
>   EXT4: migrate.c: Fixed few typos
>   EXT4: namei.c: Fixed a typo
>   EXT4: inline.c: A typo fixed
>   Fix a typo
>   EXT4: indirect.c: A trivial typo fix
>   EXT4: xattr.c: Mundane typo fix
>   EXT4: fast_commit.c: A mere typo fix
>   EXT4: mballoc.h: Single typo fix
>
>  fs/ext4/fast_commit.c | 2 +-
>  fs/ext4/indirect.c    | 2 +-
>  fs/ext4/inline.c      | 2 +-
>  fs/ext4/inode.c       | 2 +-
>  fs/ext4/mballoc.h     | 2 +-
>  fs/ext4/migrate.c     | 6 +++---
>  fs/ext4/namei.c       | 8 ++++----
>  fs/ext4/xattr.c       | 2 +-
>  8 files changed, 13 insertions(+), 13 deletions(-)

I've applied this patch series folded together into a single patch.

     	     	  	       	      - Ted
