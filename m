Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261A02B2881
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Nov 2020 23:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKMWYc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Nov 2020 17:24:32 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:48086 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMWYb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 13 Nov 2020 17:24:31 -0500
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 027972E1477;
        Sat, 14 Nov 2020 01:24:29 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id eqBv7YGGxr-OSxm4Nwj;
        Sat, 14 Nov 2020 01:24:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1605306268; bh=JiyOG15v6+8OsAdqdcl0QmQVXsLLYlEzfbVEjAlxteY=;
        h=Message-ID:In-Reply-To:Subject:To:From:References:Date:cc;
        b=fItCy9Sw84TcE/IWtG6drntUuBNbq5HTa3HmoYKxAeTCu0V9nUkSC3VR2cC7RdC6s
         P2VR/Y+DZJnMt4f+0DmyPd8W/MZ+EWW5VWTQ1MvY2c1Bk8FSh+x9w8h8PXogf21P4N
         f+D/d8SLSMuwTD6GlGApbTQjesTQvlC1S9LTxvKE=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7316::1:4])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id fnNrktIFIT-OSmmLZLn;
        Sat, 14 Nov 2020 01:24:28 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Sat, 14 Nov 2020 01:24:27 +0300 (MSK)
From:   Roman Anufriev <dotdot@yandex-team.ru>
X-X-Sender: dotdot@dotdot-osx
To:     tytso@mit.edu
cc:     linux-ext4@vger.kernel.org, jack@suse.cz,
        dmtrmonakhov@yandex-team.ru, dotdot@yandex-team.ru
Subject: Re: [PATCH v4 2/2] ext4: print quota journalling mode on
 (re-)mount
In-Reply-To: <20201023154804.GD9119@quack2.suse.cz>
Message-ID: <alpine.OSX.2.23.453.2011140120160.58713@dotdot-osx>
References: <1603336860-16153-1-git-send-email-dotdot@yandex-team.ru> <1603336860-16153-2-git-send-email-dotdot@yandex-team.ru> <20201023154804.GD9119@quack2.suse.cz>
User-Agent: Alpine 2.23 (OSX 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi! My patch was reviewed by Jan Kara, could you please take a look at it?

 								Roman
