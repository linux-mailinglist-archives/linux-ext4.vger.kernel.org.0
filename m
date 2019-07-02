Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740415D8B1
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 02:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfGCA1f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jul 2019 20:27:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32964 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726291AbfGCA1f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jul 2019 20:27:35 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62LvS8G031701
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 17:57:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8CE0E42002E; Tue,  2 Jul 2019 17:57:28 -0400 (EDT)
Date:   Tue, 2 Jul 2019 17:57:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] ext4: Fix coverity warning on error path of filename
 setup
Message-ID: <20190702215728.GI3032@mit.edu>
References: <20190624122906.GA30836@mwanda>
 <85r27dlay3.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85r27dlay3.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 28, 2019 at 04:19:32PM -0400, Gabriel Krisman Bertazi wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> 
> > Hello Gabriel Krisman Bertazi,
> >
> > The patch 3ae72562ad91: "ext4: optimize case-insensitive lookups"
> > from Jun 19, 2019, leads to the following static checker warning:
> 
> Hi,
> 
> The patch below should fix this issue.
> 
> -- >8 --
> Subject: [PATCH] ext4: Fix coverity warning on error path of filename setup
> 
> Fix the following coverity warning reported by Dan Carpenter:
> 
> fs/ext4/namei.c:1311 ext4_fname_setup_ci_filename()
> 	  warn: 'cf_name->len' unsigned <= 0
> 
> Fixes: 3ae72562ad91 ("ext4: optimize case-insensitive lookups")
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.

					- Ted
