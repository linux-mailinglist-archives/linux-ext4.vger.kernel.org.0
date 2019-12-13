Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1139B11EAB7
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2019 19:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfLMSuI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Dec 2019 13:50:08 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58079 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728455AbfLMSuH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Dec 2019 13:50:07 -0500
Received: from callcc.thunk.org (guestnat-104-132-34-105.corp.google.com [104.132.34.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBDIo2ci017037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 13:50:03 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7088E420E60; Fri, 13 Dec 2019 13:50:02 -0500 (EST)
Date:   Fri, 13 Dec 2019 13:50:02 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH -v2 1/2] ext4: save the error code which triggered an
 ext4_error() in the superblock
Message-ID: <20191213185002.GC273569@mit.edu>
References: <20191204032335.7683-1-tytso@mit.edu>
 <20191213112910.GD15474@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213112910.GD15474@quack2.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 13, 2019 at 12:29:10PM +0100, Jan Kara wrote:
> On Tue 03-12-19 22:23:34, Theodore Ts'o wrote:
> > This allows the cause of an ext4_error() report to be categorized
> > based on whether it was triggered due to an I/O error, or an memory
> > allocation error, or other possible causes.  Most errors are caused by
> > a detected file system inconsistency, so the default code stored in
> > the superblock will be EXT4_ERR_EFSCORRUPTED.
> > 
> > Previous-Version-Link: https://lore.kernel.org/r/20191121183036.29385-1-tytso@mit.edu
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> Somewhat late to the party but: Seeing that you basically call
> ext4_set_errno() before every ext4_error() call (or its variants), won't it
> be more concise and less error proned to add errno as an argument to
> ext4_error() and handle setting from there? Or are there times where you
> don't want error set?

There are about 100 calls to ext4_error or its variants in fs/ext4.
This patch inserts ext4_set_errno() before roughly 20 of them.  Most
of the time, we call ext4_error() because we've found a file system
inconsistency.  So the default if ext4_set_errno() hasn't been called
is EXT4_ERR_EFSCORRUPTED.

I thought about adding errno as an argument to ext4_error(), but it
would have substantially increased the size of the patch.

Cheers,

						- Ted
