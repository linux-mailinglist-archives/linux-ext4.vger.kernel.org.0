Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480529D47E
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbfHZQvL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 12:51:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35621 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730248AbfHZQvK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Aug 2019 12:51:10 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7QGp6Ck026901
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 12:51:07 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4BAFF42049E; Mon, 26 Aug 2019 12:51:06 -0400 (EDT)
Date:   Mon, 26 Aug 2019 12:51:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: question about jbd2 checksum v2 and v3 flag
Message-ID: <20190826165106.GF4918@mit.edu>
References: <CAPLK-i8xE4n8BJ-Beu0f80PC2W6b-A30nwcz+V_bCb_iAyB++Q@mail.gmail.com>
 <FF31C738-6B87-434B-9736-76286ED0F8E3@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF31C738-6B87-434B-9736-76286ED0F8E3@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Aug 25, 2019 at 09:05:36PM -0600, Andreas Dilger wrote:
> See description of the compat/incompat/ro_compat fields at:
> 
> https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#The_Super_Block
>

Hey Andreas,

As an aside, thanks for puting the above wiki page.  Any chance you
could also send a patch to update Documentation/filesystems/ext4/super.rst?

Many thanks!!

					- Ted
