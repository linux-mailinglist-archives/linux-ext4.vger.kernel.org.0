Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 909C219B3F2
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 18:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbgDAQ1s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 12:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387535AbgDAQ1q (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 1 Apr 2020 12:27:46 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABCF7212CC;
        Wed,  1 Apr 2020 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758465;
        bh=TkKo6Icq4q+FIk93+We08kxxyrlHLPUYaCaLGv/Nnog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paJFVkNhpcXA6ZXNUOMT0gIxi+GmrY/y/NCJy4z1ZvWZ6j5UX6RC1vwhBxlpmbdBl
         pVxKQVRt1xrpLTn46P4TLVyVFeThO5UL8fs90yZa/yPMCJi0X24Wg/QRiS1MM5kpc4
         kg+jC0JTkxN+flVBU6nEYrw/CclP8LOeNcOjo5l0=
Date:   Wed, 1 Apr 2020 09:27:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: Exporting ext4-specific information through fsinfo attributes
Message-ID: <20200401162744.GB201933@gmail.com>
References: <2461554.1585726747@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2461554.1585726747@warthog.procyon.org.uk>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 01, 2020 at 08:39:07AM +0100, David Howells wrote:
> Hi Ted,
> 
> Whilst we were at Vault, I asked you if there was any live ext4 information
> that it could be useful to export through fsinfo().  I've implemented a patch
> that exports six superblock timestamps:
> 
> 	FSINFO_ATTR_EXT4_TIMESTAMPS: 
> 		mkfs    : 2016-02-26 00:37:03
> 		mount   : 2020-03-31 21:57:30
> 		write   : 2020-03-31 21:57:28
> 		fsck    : 2018-12-17 23:32:45
> 		1st-err : -
> 		last-err: -
> 
> but is there anything else that could be of interest?
> 
> Thanks,
> David
> 

FWIW, the filesystem UUID would be useful for testing ext4 and f2fs encryption
(since it's now sometimes used in the derivation of encryption keys).  But I see
you already included it as FSINFO_ATTR_VOLUME_UUID.

- Eric
