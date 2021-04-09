Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84A635A8F1
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Apr 2021 00:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhDIWpx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 18:45:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57548 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234880AbhDIWpv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 18:45:51 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 139MjYwu030021
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 18:45:34 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4853C15C3B12; Fri,  9 Apr 2021 18:45:34 -0400 (EDT)
Date:   Fri, 9 Apr 2021 18:45:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Fengnan Chang <changfengnan@vivo.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] ext4: fix error code in ext4_commit_super
Message-ID: <YHDZDt+EZ5/iErIr@mit.edu>
References: <20210402101631.561-1-changfengnan@vivo.com>
 <F552F506-E58D-4705-A2B5-FA2DD8BA2F92@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F552F506-E58D-4705-A2B5-FA2DD8BA2F92@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Apr 03, 2021 at 12:34:50PM -0600, Andreas Dilger wrote:
> On Apr 2, 2021, at 4:16 AM, Fengnan Chang <changfengnan@vivo.com> wrote:
> > 
> > We should set the error code when ext4_commit_super check argument failed.
> > Found in code review.
> > Fixes: c4be0c1dc4cdc ("filesystem freeze: add error handling of write_super_lockfs/unlockfs").
> > 
> > Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

						- Ted
