Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D357E3147AA
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Feb 2021 05:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBIEth (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Feb 2021 23:49:37 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41079 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229671AbhBIEth (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Feb 2021 23:49:37 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1194mlQZ027491
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 Feb 2021 23:48:48 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8B36115C39D8; Mon,  8 Feb 2021 23:48:47 -0500 (EST)
Date:   Mon, 8 Feb 2021 23:48:47 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] e2fsck: don't print errcode if the errcode is 0
Message-ID: <YCIUL2ilfnKvQFjD@mit.edu>
References: <20210204233601.2369470-1-harshads@google.com>
 <20210204233601.2369470-2-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204233601.2369470-2-harshads@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 04, 2021 at 03:36:00PM -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> We print the error message corresponding to errcode while converting
> errcode to errno. Don't do that if errcode is 0.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

It looks like this change is already in commit 63b7192cae60 ("e2fsck:
add fc replay for link, unlink, creat tags") which is already in the
upstream repo?

						- Ted
