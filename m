Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065E95D8B4
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 02:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfGCA1g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jul 2019 20:27:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32965 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbfGCA1f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jul 2019 20:27:35 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62Lfp30025320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 17:41:52 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 65FDB42002E; Tue,  2 Jul 2019 17:41:51 -0400 (EDT)
Date:   Tue, 2 Jul 2019 17:41:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: replace ktype default_attrs with default_groups
Message-ID: <20190702214151.GA28833@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Kimberly Brown <kimbrownkd@gmail.com>, adilger.kernel@dilger.ca,
        gregkh@linuxfoundation.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190508200748.3907-1-kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508200748.3907-1-kimbrownkd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 08, 2019 at 04:07:48PM -0400, Kimberly Brown wrote:
> The kobj_type default_attrs field is being replaced by the
> default_groups field. Replace the default_attrs field in ext4_sb_ktype
> and ext4_feat_ktype with default_groups. Use the ATTRIBUTE_GROUPS macro
> to create ext4_groups and ext4_feat_groups.
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> ---
> 
> This patch depends on a patch in the driver-core tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=aa30f47cf666111f6bbfd15f290a27e8a7b9d854
> 
> Greg KH can take this patch through the driver-core tree, or this patch
> can wait a release cycle and go through the subsystem's tree, whichever
> the subsystem maintainer is more comfortable with.

Thanks, since that commit is in 5.2-rc2, I've applied this patch.

	      	   	     	- Ted
