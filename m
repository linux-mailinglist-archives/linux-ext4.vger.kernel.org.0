Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96491168703
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 19:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgBUSxw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 13:53:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53786 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbgBUSxw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 13:53:52 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01LIried014236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 13:53:45 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B59934211EF; Fri, 21 Feb 2020 13:53:43 -0500 (EST)
Date:   Fri, 21 Feb 2020 13:53:43 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: rename s_journal_flag_rwsem to
 s_writepages_rwsem
Message-ID: <20200221185343.GB741939@mit.edu>
References: <20200219183047.47417-1-ebiggers@kernel.org>
 <20200219183047.47417-2-ebiggers@kernel.org>
 <20200220091458.GA13232@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220091458.GA13232@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 20, 2020 at 10:14:58AM +0100, Jan Kara wrote:
> On Wed 19-02-20 10:30:46, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > In preparation for making s_journal_flag_rwsem synchronize
> > ext4_writepages() with changes to both the EXTENTS and JOURNAL_DATA
> > flags (rather than just JOURNAL_DATA as it does currently), rename it to
> > s_writepages_rwsem.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
