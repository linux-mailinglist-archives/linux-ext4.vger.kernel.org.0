Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76867FDB2
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Jan 2023 09:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjA2I5K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Jan 2023 03:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjA2I5J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Jan 2023 03:57:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2700E1E2BE;
        Sun, 29 Jan 2023 00:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674982627; x=1706518627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vUENpV2Ql4/NmK32XqXLrro2vbJXFlGGqekRc82vJ/0=;
  b=kAPrA8MNCNHqNtNRXNob5yT/X6nCS/ygW1izYrl5LxPt+YOwSLe91MrC
   e5wfFsXrjbOY2qmts6G5kGCGqD9Ju7mHQkdGnxgy4Z7LQQ2gtS5pxtRE1
   2yD3lhxmfSXG8wOVKf3GUZPvrmyJQ6spVcYmSkV0Iccga9NVLvHh0i/Ih
   z9LyFROGWLQvKE4kZTpe8J6jRyVMMoht98oeAGJG27SqWk427fx5WOiC8
   95o0+yJ7l9ALwGmNhiZd2zY9RX9TqcOokT8XkmNAVXih5CX3sdXunJ0Jf
   n01JVSmCKoKGoOHkhOxfMGF2yGkn1lnPcF9x7xI2MbzcKB9eGlANqwvYL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="315335877"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="315335877"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 00:57:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="665736856"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="665736856"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jan 2023 00:56:57 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pM3Ue-0002dm-2U;
        Sun, 29 Jan 2023 08:56:56 +0000
Date:   Sun, 29 Jan 2023 16:56:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <max.byungchul.park@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org
Subject: Re: [PATCH v8 05/25] dept: Tie to Lockdep and IRQ tracing
Message-ID: <202301291601.7591xziv-lkp@intel.com>
References: <1674782358-25542-6-git-send-email-max.byungchul.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674782358-25542-6-git-send-email-max.byungchul.park@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Byungchul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on tip/sched/core drm-misc/drm-misc-next linus/master v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230128-102456
patch link:    https://lore.kernel.org/r/1674782358-25542-6-git-send-email-max.byungchul.park%40gmail.com
patch subject: [PATCH v8 05/25] dept: Tie to Lockdep and IRQ tracing
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230129/202301291601.7591xziv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/aed5169e3b6767146ee602447fcf75b4c734d2db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Byungchul-Park/llist-Move-llist_-head-node-definition-to-types-h/20230128-102456
        git checkout aed5169e3b6767146ee602447fcf75b4c734d2db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/ethernet/microchip/vcap/ drivers/platform/chrome/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/chrome/cros_ec_proto_test.c: In function 'cros_ec_proto_test_get_sensor_count_xfer_error':
>> drivers/platform/chrome/cros_ec_proto_test.c:2528:1: warning: the frame size of 2072 bytes is larger than 2048 bytes [-Wframe-larger-than=]
    2528 | }
         | ^
   drivers/platform/chrome/cros_ec_proto_test.c: In function 'cros_ec_proto_test_get_sensor_count_normal':
   drivers/platform/chrome/cros_ec_proto_test.c:2488:1: warning: the frame size of 2072 bytes is larger than 2048 bytes [-Wframe-larger-than=]
    2488 | }
         | ^
   drivers/platform/chrome/cros_ec_proto_test.c: In function 'cros_ec_proto_test_get_sensor_count_legacy':
   drivers/platform/chrome/cros_ec_proto_test.c:2593:1: warning: the frame size of 2136 bytes is larger than 2048 bytes [-Wframe-larger-than=]
    2593 | }
         | ^
   drivers/platform/chrome/cros_ec_proto_test.c: In function 'cros_ec_proto_test_check_features_not_cached':
   drivers/platform/chrome/cros_ec_proto_test.c:2443:1: warning: the frame size of 2056 bytes is larger than 2048 bytes [-Wframe-larger-than=]
    2443 | }
         | ^
--
   In file included from drivers/net/ethernet/microchip/vcap/vcap_api.c:2882:
   drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c: In function 'vcap_api_next_lookup_advanced_test':
>> drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:1955:1: warning: the frame size of 2240 bytes is larger than 2048 bytes [-Wframe-larger-than=]
    1955 | }
         | ^


vim +2528 drivers/platform/chrome/cros_ec_proto_test.c

33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2489  
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2490  static void cros_ec_proto_test_get_sensor_count_xfer_error(struct kunit *test)
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2491  {
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2492  	struct cros_ec_proto_test_priv *priv = test->priv;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2493  	struct cros_ec_device *ec_dev = &priv->ec_dev;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2494  	struct ec_xfer_mock *mock;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2495  	int ret;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2496  	struct cros_ec_dev ec;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2497  
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2498  	ec_dev->max_request = 0xff;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2499  	ec_dev->max_response = 0xee;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2500  	ec.ec_dev = ec_dev;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2501  	ec.dev = ec_dev->dev;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2502  	ec.cmd_offset = 0;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2503  
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2504  	/* For EC_CMD_MOTION_SENSE_CMD. */
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2505  	{
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2506  		mock = cros_kunit_ec_xfer_mock_addx(test, -EPROTO, EC_RES_SUCCESS, 0);
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2507  		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2508  	}
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2509  
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2510  	ret = cros_ec_get_sensor_count(&ec);
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2511  	KUNIT_EXPECT_EQ(test, ret, -EPROTO);
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2512  
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2513  	/* For EC_CMD_MOTION_SENSE_CMD. */
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2514  	{
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2515  		struct ec_params_motion_sense *data;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2516  
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2517  		mock = cros_kunit_ec_xfer_mock_next();
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2518  		KUNIT_EXPECT_PTR_NE(test, mock, NULL);
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2519  
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2520  		KUNIT_EXPECT_EQ(test, mock->msg.version, 1);
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2521  		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MOTION_SENSE_CMD);
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2522  		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_motion_sense));
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2523  		KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2524  
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2525  		data = (struct ec_params_motion_sense *)mock->i_data;
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2526  		KUNIT_EXPECT_EQ(test, data->cmd, MOTIONSENSE_CMD_DUMP);
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2527  	}
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22 @2528  }
33f0fdba6066b5 Tzung-Bi Shih 2022-06-22  2529  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
