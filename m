Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6200C135F38
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgAIRY4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 12:24:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33824 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728444AbgAIRY4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jan 2020 12:24:56 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 009HOpHk031966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Jan 2020 12:24:52 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 846494207DF; Thu,  9 Jan 2020 12:24:51 -0500 (EST)
Date:   Thu, 9 Jan 2020 12:24:51 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: export information about first/last errors via
 /sys/fs/ext4/<dev>
Message-ID: <20200109172451.GD33929@mit.edu>
References: <20191224000541.88473-1-tytso@mit.edu>
 <20200109091240.GA27035@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109091240.GA27035@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 09, 2020 at 10:12:40AM +0100, Jan Kara wrote:
> On Mon 23-12-19 19:05:41, Theodore Ts'o wrote:
> > Make {first,last}_error_{ino,block,line,func,errcode} available via
> > sysfs.
> > 
> > Also add a missing newline for {first,last}_error_time.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I'm just wondering a bit why do you need this? Some system monitoring
> thing?

Yes, precisely.  Especially in cloud environments, where the disk
often gets deleted when the VM is terminated, so reading the this
information from the superblock won't be possible.

						- Ted
