Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001B516661E
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 19:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgBTSWi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 13:22:38 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35025 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbgBTSWi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Feb 2020 13:22:38 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01KIMVEF003070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 13:22:33 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 60F254211EF; Thu, 20 Feb 2020 13:22:31 -0500 (EST)
Date:   Thu, 20 Feb 2020 13:22:31 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] ext4: fix handling mount -o remount,nolazytime
Message-ID: <20200220182231.GA602834@mit.edu>
References: <158210399258.5335.3994877510070204710.stgit@buzz>
 <20200219162242.GI330201@mit.edu>
 <2326451b-faf2-72a5-cb55-89cb6d8ce9ed@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2326451b-faf2-72a5-cb55-89cb6d8ce9ed@yandex-team.ru>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 20, 2020 at 06:11:04PM +0300, Konstantin Khlebnikov wrote:
> Usually all these options are saved in /etc/fstab and
> mount -o remount,... includes them into line passed into syscall.
> In this case remounting any other option will not disable lazytime.

This assumes that there *is* an /etc/fstab entry.  Sometimes system
administrators will perform ad hoc mounts of devices that aren't
mentioned in /etc/fstab.

For example, consider how xfstests works; it will run mounts commands
mentioning the test and scratch devices which are not mentioned on
/etc/fstab.


						- Ted
