Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446092DBA3C
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 05:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgLPE4C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Dec 2020 23:56:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37653 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725385AbgLPE4C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Dec 2020 23:56:02 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BG4tAHm024482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 23:55:11 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 92B51420280; Tue, 15 Dec 2020 23:55:10 -0500 (EST)
Date:   Tue, 15 Dec 2020 23:55:10 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: make fast_commit.h byte identical with
 e2fsprogs/fast_commit.h
Message-ID: <X9mTLvIMWeePAERU@mit.edu>
References: <20201120202232.2240293-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120202232.2240293-1-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 20, 2020 at 12:22:31PM -0800, Harshad Shirwadkar wrote:
> This patch makes fast_commit.h byte by byte identical with
> e2fsprogs/fast_commit.h. This will help us ensure that there are no
> on-disk format inconsistencies between e2fsck and kernel ext4.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks, applied.

				- Ted
