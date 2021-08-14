Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D8E3EC322
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Aug 2021 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhHNOPK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Aug 2021 10:15:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53040 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232315AbhHNOPI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Aug 2021 10:15:08 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17EEEZbg018324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Aug 2021 10:14:36 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B103D15C37C1; Sat, 14 Aug 2021 10:14:35 -0400 (EDT)
Date:   Sat, 14 Aug 2021 10:14:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix fast commit alignment issues
Message-ID: <YRfPyx+xOanN4uWu@mit.edu>
References: <20210811212414.14468-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811212414.14468-1-harshads@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 11, 2021 at 02:24:14PM -0700, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> This patch ports following fast commit alignment issues merged in
> e2fsprogs to ext4 in kernel:
> 
> https://patchwork.ozlabs.org/project/linux-ext4/list/?series=242554&state=*
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

It appears this patch had landed already in 5.13 as a7ba36bc94f20
("ext4: fix fast commit alignment issues").

Cheers,

						- Ted
