Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282B320D92
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 19:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfEPQ77 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 12:59:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46828 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726449AbfEPQ77 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 May 2019 12:59:59 -0400
Received: from callcc.thunk.org (168-215-239-3.static.ctl.one [168.215.239.3] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4GGxMQ2021387
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 May 2019 12:59:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 74866420024; Thu, 16 May 2019 12:59:21 -0400 (EDT)
Date:   Thu, 16 May 2019 12:59:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: generic, fsync fuzz tester with fsstress
Message-ID: <20190516165921.GA4023@mit.edu>
References: <20190515150221.16647-1-fdmanana@kernel.org>
 <20190516092848.GA6975@mit.edu>
 <CAL3q7H7q5Xphhax3qPdt1fnjaWrekMgMKzKfDyOLm+bbgsw6Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7q5Xphhax3qPdt1fnjaWrekMgMKzKfDyOLm+bbgsw6Aw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 16, 2019 at 10:54:57AM +0100, Filipe Manana wrote:
> 
> Haven't tried ext4 with 1 process only (instead of 4), but I can try
> to see if it happens without concurrency as well.

How many CPU's and how much memory were you using?  And I assume this
was using KVM/QEMU?  How was it configured?

Thanks,

					- Ted
