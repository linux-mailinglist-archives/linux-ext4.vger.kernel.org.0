Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29BF2924D4
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgJSJqb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:46:31 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:38440 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbgJSJqb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Oct 2020 05:46:31 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net (myt5-23f0be3aa648.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id BC4752E14E2;
        Mon, 19 Oct 2020 12:46:28 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id IPMI0YLoex-kSw4YpCw;
        Mon, 19 Oct 2020 12:46:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1603100788; bh=arIgPZalihP/69C1JAK3ZgLNWhmZ7XrmDZzHmKKF1To=;
        h=Message-ID:In-Reply-To:Subject:To:From:References:Date:cc;
        b=yBtR0rppHO22W8mYBZvZe6heMmqxuFDa5DobQ00C9jZp+LOoBnEmvNB8b3ydFfQgl
         SrnXKU3Mdp3LO00CoKYOmel/rWV54M8n28RA+yvD6jpWSEQt5KTJeEvL6KL3OflUSJ
         b8c5Rz96wrZtfntaN5deou6oQ1vXQNCPNxhmGqAk=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:6506::1:11])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id z5TSsURakM-kRn04Db2;
        Mon, 19 Oct 2020 12:46:28 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Mon, 19 Oct 2020 12:46:27 +0300 (MSK)
From:   Roman Anufriev <dotdot@yandex-team.ru>
X-X-Sender: dotdot@dotdot-osx
To:     kernel test robot <lkp@intel.com>
cc:     linux-ext4@vger.kernel.org, kbuild-all@lists.01.org, tytso@mit.edu,
        jack@suse.cz, dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH v2 2/2] ext4: print quota journalling mode on
 (re-)mount
In-Reply-To: <202010181112.IujKPiIE-lkp@intel.com>
Message-ID: <alpine.OSX.2.23.453.2010191244500.55532@dotdot-osx>
References: <1602986547-15886-2-git-send-email-dotdot@yandex-team.ru> <202010181112.IujKPiIE-lkp@intel.com>
User-Agent: Alpine 2.23 (OSX 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, 18 Oct 2020, kernel test robot wrote:

> Hi Roman,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on ext4/dev]
> [also build test ERROR on v5.9 next-20201016]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Roman-Anufriev/ext4-add-helpers-for-checking-whether-quota-can-be-enabled-is-journalled/20201018-100410
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> config: i386-randconfig-m021-20201018 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>        # https://github.com/0day-ci/linux/commit/9ee2e9dad32135b665f733b714c75ff22731bbcd
>        git remote add linux-review https://github.com/0day-ci/linux
>        git fetch --no-tags linux-review Roman-Anufriev/ext4-add-helpers-for-checking-whether-quota-can-be-enabled-is-journalled/20201018-100410
>        git checkout 9ee2e9dad32135b665f733b714c75ff22731bbcd
>        # save the attached .config to linux build tree
>        make W=1 ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>   fs/ext4/super.c: In function 'ext4_quota_mode':
>>> fs/ext4/super.c:3999:19: error: expected ';' before '}' token
>    3999 |  return "disabled"
>         |                   ^
>         |                   ;
>    4000 | #endif
>    4001 | }
>         | ~
>   fs/ext4/super.c: In function 'ext4_remount':
>   fs/ext4/super.c:5738:6: warning: variable 'enable_quota' set but not used [-Wunused-but-set-variable]
>    5738 |  int enable_quota = 0;
>         |      ^~~~~~~~~~~~
>
> vim +3999 fs/ext4/super.c
>
>  3987
>  3988	static const char *ext4_quota_mode(struct super_block *sb)
>  3989	{
>  3990	#ifdef CONFIG_QUOTA
>  3991		if (!ext4_quota_capable(sb))
>  3992			return "none";
>  3993
>  3994		if (ext4_is_quota_journalled(sb))
>  3995			return "journalled";
>  3996		else
>  3997			return "writeback";
>  3998	#else
>> 3999		return "disabled"
>  4000	#endif
>  4001	}
>  4002
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Fixed missing semicolon in v3:
https://lore.kernel.org/linux-ext4/1603099162-25028-1-git-send-email-dotdot@yandex-team.ru/

 								Roman
