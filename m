Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A4638BD08
	for <lists+linux-ext4@lfdr.de>; Fri, 21 May 2021 05:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhEUDx7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 May 2021 23:53:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57233 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233879AbhEUDx6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 May 2021 23:53:58 -0400
Received: from callcc.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14L3qVqZ024245
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 23:52:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 40EE1420119; Thu, 20 May 2021 23:52:31 -0400 (EDT)
Date:   Thu, 20 May 2021 23:52:31 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: ext4: mballoc: amend goto to cleanup groupinfo
 memory correctly
Message-ID: <YKcuf0eYcMIELjEj@mit.edu>
References: <YI0czH0auvWlU8bA@equinox>
 <6E6AEEB4-1FBA-40F1-8328-8E304E68A7C6@dilger.ca>
 <YI6DqtMHj9dx26Kw@equinox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI6DqtMHj9dx26Kw@equinox>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, applied, with a cleaned up commit description.

Cheers,

					- Ted
