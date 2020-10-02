Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BEA28165E
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Oct 2020 17:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbgJBPR3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Oct 2020 11:17:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57434 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgJBPR2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Oct 2020 11:17:28 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 092FHO2B006959
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Oct 2020 11:17:24 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2C44E42003C; Fri,  2 Oct 2020 11:17:24 -0400 (EDT)
Date:   Fri, 2 Oct 2020 11:17:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: State of dump utility
Message-ID: <20201002151724.GT23474@mit.edu>
References: <20200929143713.ttu2vvhq22ulslwf@work>
 <20200930020646.GD23474@mit.edu>
 <20201002120158.uyyx3cg5gdeoe665@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002120158.uyyx3cg5gdeoe665@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 02, 2020 at 02:01:58PM +0200, Lukas Czerner wrote:
> 
> Thanks Ted, you made some good points and while there are some good
> ideas for the future, there is no place for dump there. I think we're in
> agreement to pull the plug on dump.

I think the only strong argument for dump/restore is that there might
be some crazy^H^H^H^H^H^H dedicated hobbiests over at The Unix
Historical Society who might find a 9-track tape with some 2.10 BSD
backup on it, and dump/restore is format compatible with it.  So
_restore_ might be interesting for some of those folks.  Then again,
they'd probably prefer to actually restore it on their 2.10 BSD system
running on a PDP-11 emulator.... so we're probably good.  :-)

	     	    		    	  - Ted
