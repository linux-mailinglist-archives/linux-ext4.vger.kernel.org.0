Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B1A32EE45
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 16:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCEPS7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 10:18:59 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55530 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229679AbhCEPS2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 10:18:28 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 125FIGgY009749
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 Mar 2021 10:18:16 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2FE7815C3A88; Fri,  5 Mar 2021 10:18:16 -0500 (EST)
Date:   Fri, 5 Mar 2021 10:18:16 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] inode.i_opflags - Usage of two different locking schemes
Message-ID: <YEJLuP6+Zy8/dq+D@mit.edu>
References: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
 <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 05, 2021 at 02:10:09PM +0100, Alexander Lochmann wrote:
> Hi folks,
> 
> I've stumbled across an interesting locking scheme. It's related to struct
> inode, more precisely it is an mqueue inode.
> Our results show that inode:mqueue.i_opflags is read with i_rwsem being
> hold.
> In d_flags_for_inode, and do_inode_permission the i_lock is used to read and
> write i_opflags.
> Is this a real locking scheme? Is a lock needed to access i_opflags at all?
> What is the magic behind this contradiction?
> 
> I've put the report of the counterexamples on our webserver:
> https://ess.cs.tu-dortmund.de/lockdoc-bugs/cex-inode-mqueue.html.
> It contains the stacktraces leading to those accesses, and the locks that
> were actually held.

1)  I don't see where i_opflags is being read in ipc/mqueue.c at all,
either with or without i_rwsem.

2)  I'm not sure what this has to do with ext4?

        	    	      	       	  - Ted
