Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08AEEE0AE
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 14:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfKDNJx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 08:09:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37604 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729136AbfKDNJg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 08:09:36 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA4D9Ul7004768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Nov 2019 08:09:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 47C66420311; Mon,  4 Nov 2019 08:09:28 -0500 (EST)
Date:   Mon, 4 Nov 2019 08:09:28 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/19 v3] ext4: Fix transaction overflow due to revoke
 descriptors
Message-ID: <20191104130928.GD28764@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191104033252.GC12046@mit.edu>
 <20191104112232.GD22379@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104112232.GD22379@quack2.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 04, 2019 at 12:22:32PM +0100, Jan Kara wrote:
> Hi Ted!
> 
> On Sun 03-11-19 22:32:52, Theodore Y. Ts'o wrote:
> > I believe that I'm waiting for the v4 version of this series with some
> > pending fixes that you are planning on making.  Is that correct?
> 
> Ah, good that you pinged me because I have the series ready but I was
> waiting for your answers to some explanations... In particular discussion
> around patch 3 (move iput() outside of transaction), patch 15 (dropping of
> j_state_lock around t_tid load), patch 18 (possible large overreservation
> of descriptor blocks due to rounding), and 21 (change of on-disk format for
> revoke descriptors).

Sorry, I didn't comment because I accepted your arguments; but I guess
I should have said so explicitly.  I just replied to those threads.

> Out of these I probably find the overreservation due to rounding the most
> serious and easy enough to handle so I'll fix that and then resend the
> series unless you raise your objection also in some other case.

Great!

					- Ted
