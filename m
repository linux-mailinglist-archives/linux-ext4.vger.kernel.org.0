Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB74354AF8
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Apr 2021 04:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242287AbhDFCla (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Apr 2021 22:41:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38275 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239096AbhDFCla (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Apr 2021 22:41:30 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1362doKl031316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Apr 2021 22:39:51 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5705115C3399; Mon,  5 Apr 2021 22:39:50 -0400 (EDT)
Date:   Mon, 5 Apr 2021 22:39:50 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Arnd Bergmann <arnd@kernel.org>, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        Hui Su <sh_def@163.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: avoid -Wempty-body warnings
Message-ID: <YGvJ9vQftwVC9S7h@mit.edu>
References: <20210322102152.95684-1-arnd@kernel.org>
 <20210330151533.GA10067@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330151533.GA10067@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 30, 2021 at 05:15:33PM +0200, Jan Kara wrote:
> On Mon 22-03-21 11:21:38, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Building with 'make W=1' shows a harmless -Wempty-body warning:
> > 
> > fs/jbd2/recovery.c: In function 'fc_do_one_pass':
> > fs/jbd2/recovery.c:267:75: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
> >   267 |                 jbd_debug(3, "Fast commit replay failed, err = %d\n", err);
> >       |                                                                           ^
> > 
> > Change the empty dprintk() macros to no_printk(), which avoids this
> > warning and adds format string checking.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Sure. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
