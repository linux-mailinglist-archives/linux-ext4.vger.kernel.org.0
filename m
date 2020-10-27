Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301BA29CB4E
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Oct 2020 22:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374150AbgJ0Vet (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Oct 2020 17:34:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41574 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S374132AbgJ0Ves (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Oct 2020 17:34:48 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09RLQbBt015134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 17:26:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9F4BB420107; Tue, 27 Oct 2020 17:26:37 -0400 (EDT)
Date:   Tue, 27 Oct 2020 17:26:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 23/32] jbd2: fix a kernel-doc markup
Message-ID: <20201027212637.GF5691@mit.edu>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
 <6055927ada2015b55b413cdd2670533bdc9a8da2.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6055927ada2015b55b413cdd2670533bdc9a8da2.1603791716.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 27, 2020 at 10:51:27AM +0100, Mauro Carvalho Chehab wrote:
> The kernel-doc markup that documents _fc_replay_callback is
> missing an asterisk, causing this warning:
> 
> 	../include/linux/jbd2.h:1271: warning: Function parameter or member 'j_fc_replay_callback' not described in 'journal_s'
> 
> When building the docs.
> 
> Fixes: 609f928af48f ("jbd2: fast commit recovery path")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks, I'm accomulating some bug fix patches to push to Linus, so
I'll grab this for the ext4 git tree.

     	       	       	    	- Ted
