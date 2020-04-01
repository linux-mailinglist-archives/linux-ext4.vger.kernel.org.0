Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC919B71C
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 22:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbgDAUgn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 16:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732337AbgDAUgn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 1 Apr 2020 16:36:43 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514BA20784;
        Wed,  1 Apr 2020 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585773402;
        bh=BGEIqF3YhkeU8jLK+6beLZYFBd2iXU20xNB4/tQPfxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zze/sIJT/BdLiEH2jgJUkpRo4EwiT2RsINo5fLxZ2GNoAXCgWQXklv2l2F8Dh3Imy
         pYqpo8QCNx7mWJKY8aRP4i1Mkn7YoBbC7e6TWXDDYTdz2aGSDioAgNvKuAS10EL7QG
         0JqGrRUuVXC0dD4+THdTcI++EA3zk8coRKbo06IE=
Date:   Wed, 1 Apr 2020 13:36:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     David Howells <dhowells@redhat.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: Exporting ext4-specific information through fsinfo attributes
Message-ID: <20200401203640.GD201933@gmail.com>
References: <2461554.1585726747@warthog.procyon.org.uk>
 <20200401162744.GB201933@gmail.com>
 <20200401190553.GC56931@magnolia>
 <20200401192840.GC201933@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401192840.GC201933@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 01, 2020 at 12:28:40PM -0700, Eric Biggers wrote:
> We maybe should make tune2fs -U refuse to operate on filesystems that have the
> stable_inodes feature set.

I sent patches to do this and clean up a few other things:

https://lkml.kernel.org/linux-ext4/20200401203239.163679-1-ebiggers@kernel.org

- Eric
