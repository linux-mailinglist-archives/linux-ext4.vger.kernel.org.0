Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39001493E9
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 08:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgAYHbT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jan 2020 02:31:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53087 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgAYHbT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jan 2020 02:31:19 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P7VAjT026644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 02:31:12 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A168E42014A; Sat, 25 Jan 2020 02:31:09 -0500 (EST)
Date:   Sat, 25 Jan 2020 02:31:09 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/1] jbd2_seq_info_next should increase position index
Message-ID: <20200125073109.GH1108497@mit.edu>
References: <d13805e5-695e-8ac3-b678-26ca2313629f@virtuozzo.com>
 <20200123111543.GC5728@quack2.suse.cz>
 <43e6a168-63b6-4a82-7b3d-5dd676b9f9bb@virtuozzo.com>
 <20200123140243.GA7914@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123140243.GA7914@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 23, 2020 at 03:02:43PM +0100, Jan Kara wrote:
> On Thu 23-01-20 14:30:14, Vasily Averin wrote:
> > 
> > 
> > On 1/23/20 2:15 PM, Jan Kara wrote:
> > > On Thu 23-01-20 12:05:10, Vasily Averin wrote:
> > >> if seq_file .next fuction does not change position index,
> > >> read after some lseek can generate unexpected output.
> > >>
> > >> Script below generates endless output
> > >>  $ q=;while read -r r;do echo "$((++q)) $r";done </proc/fs/jbd2/DEV/info
> > > 
> > > I've just tried and this works for me just fine with openSUSE 15.1
> > > (4.12.14-based) kernel. Is it some recent regression?
> > 
> > I think it depends on 
> > commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> > In OpenVz7 we got complain after backport of this patch.
> 
> I see. OK. So please add tag:
> 
> Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> 
> likely also:
> 
> CC: stable@vger.kernel.org
> 
> and you can also add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied with the suggested tags.

						- Ted
