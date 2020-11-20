Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0742BA149
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 04:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKTDjN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Nov 2020 22:39:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52895 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726515AbgKTDjN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Nov 2020 22:39:13 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AK3cxbU028976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 22:39:00 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AF20A420107; Thu, 19 Nov 2020 22:38:59 -0500 (EST)
Date:   Thu, 19 Nov 2020 22:38:59 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jan Kara <jack@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 12/27] jbd2: fix kernel-doc markups
Message-ID: <20201120033859.GB695373@mit.edu>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
 <72f5c6628f5f278d67625f60893ffbc2ca28d46e.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72f5c6628f5f278d67625f60893ffbc2ca28d46e.1605521731.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 16, 2020 at 11:18:08AM +0100, Mauro Carvalho Chehab wrote:
> Kernel-doc markup should use this format:
>         identifier - description
> 
> They should not have any type before that, as otherwise
> the parser won't do the right thing.
> 
> Also, some identifiers have different names between their
> prototypes and the kernel-doc markup.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied to the ext4 tree, thanks!

					- Ted
