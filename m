Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826742FF0F9
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 17:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbhAUQus (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 11:50:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41758 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388168AbhAUQuq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 11:50:46 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10LGnwaL026890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 11:49:58 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EEFE815C35F5; Thu, 21 Jan 2021 11:49:57 -0500 (EST)
Date:   Thu, 21 Jan 2021 11:49:57 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 13/15] debugfs: add fast commit support to logdump
Message-ID: <YAmwtZzCoDUM+m7O@mit.edu>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
 <20210120212641.526556-14-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120212641.526556-14-user@harshads-520.kir.corp.google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 20, 2021 at 01:26:39PM -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Add fast commit support for debugfs logdump. The debugfs output looks
> like this:

I've applied this patch set, with slight changes.  In particular this
commit relies on lib/ext2fs/fast_commit.h which is byte-for-byte
identical with the kernel fast_commit.h, and which originally added in
patch #8 of this series ("e2fsck: add fast commit setup code"), so
I've added that file to this commit.

					- Ted
