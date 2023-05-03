Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212F36F5297
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjECID2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 04:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjECIDV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 04:03:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4468C49F1
        for <linux-ext4@vger.kernel.org>; Wed,  3 May 2023 01:03:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f1950f569eso30400105e9.2
        for <linux-ext4@vger.kernel.org>; Wed, 03 May 2023 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683100996; x=1685692996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l+eWFb5YopWpMxBtPeHdWtKsfUY0tMTF2cg2+EGBImo=;
        b=RcYh7J7o5M670fpeNNeALMHmr32QYd5Wovk+YvjIIjxjyZeH5kO82gm9pc0UGGKy2y
         o7yjncHXza4uNAGA7q2liRZy+PO2u5JKsTwyp3Dv6SWNyQtzqIzaOEOLPgLQCzv/f3TE
         FoY2z+1AUXZWuNy7/W4tn0K9HiUOkxIWnwfiOPHlJfQNL/Mue+DRpsyqnJxWUNXZLUIa
         qn0CxHawqB0bk4gj+ic/uFETDwbbEqChn3918gmAtEV1j4jdNiS2RjnPy4s9czcAzJBu
         1iUXb2GJu4jT15vdK9EVDw8WwBxjrWgxBE5+gsmqX3I47qOI6YWv4tX2DNwd40AumlRK
         W3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683100996; x=1685692996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+eWFb5YopWpMxBtPeHdWtKsfUY0tMTF2cg2+EGBImo=;
        b=jNHNb3ezyNRheqP6eiXqTaJjokAuzN8rkBh7f0KBewdxGBZ8lCoXWCdGMDz56EyAlp
         6E7vKkvyKn3ofso/Gme3Xhk227oGvo6LjIPO4t0t8lGhAnrQDEAidr4fqBXyr04kaaFA
         f7dFxnY3YV/vga7sSUBNwSt1BNWv50Tr2baWlOt023qwVKHI85V3G4d0WuBUxz7uV7US
         8YVERIEY/Nqi39wjbgJ99S/f/jeKEP+dsLg6ikBTK1BAHebCr3piL4yAG34movGLMPZ5
         vwjBReHS2BdvyRmOeQ2IP6mpUsTczP9u4d5bK2lWrKG44b82Vnl+mE1i2tCpXnjcn8OL
         Wa4g==
X-Gm-Message-State: AC+VfDxRxNIUvM0Mz8pvXMwb6rutS9HjjXONqZ4tkyPEIX57guKveDdE
        7nQqYYO8xAYNKZZa5vZHk5p/uw==
X-Google-Smtp-Source: ACHHUZ62ue2ORhyKOg0J7qtGH0qzeHFGvoRIKcPvn1aQGcUP1tD+kTpKHh5sIh9rjv0t6stdHumiwg==
X-Received: by 2002:a05:600c:2104:b0:3f1:6f44:ff3a with SMTP id u4-20020a05600c210400b003f16f44ff3amr13679819wml.13.1683100996375;
        Wed, 03 May 2023 01:03:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c379200b003f17300c7dcsm1030354wmr.48.2023.05.03.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 01:03:13 -0700 (PDT)
Date:   Wed, 3 May 2023 11:03:10 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
Message-ID: <945ae350-9a82-495a-9983-f42c0eb13100@kili.mountain>
References: <20230425041838.GA150312@mit.edu>
 <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <ZEl3QmF1PYXKaBTz@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mLVOHNju7DtbO5jx"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEl3QmF1PYXKaBTz@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--mLVOHNju7DtbO5jx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 26, 2023 at 08:10:58PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 26, 2023 at 10:03:37AM -0700, Linus Torvalds wrote:
> > On Mon, Apr 24, 2023 at 9:18 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > >
> > > Please note that after merging the mm and ext4 trees you will need to
> > > apply the patch found here[1].
> > >
> > > [1] https://lore.kernel.org/r/20230419120923.3152939-1-willy@infradead.org
> > >
> > > This is due to a patch in the mm tree, "mm: return an ERR_PTR from
> > > __filemap_get_folio" changing that function to returning an ERR_PTR
> > > instead of returning NULL on an error.
> > 
> > Side note, itr would be wonderful if we could mark the places that
> > return an error pointer as returning "nonnull", and catch things like
> > this automatically at build time where people compare an error pointer
> > to NULL.
> 
> This feels like something smatch could catch.  Adding Dan.
> 
> Unfortunately, I don't know that we have any buildbots that run smatch,
> and most developers don't, so it'll always be an after-the-fact patch
> to fix it rather than "anybody using W=1" or "anybody using C=1" will
> catch it before it gets anywhere near a maintainer.

There is a Smatch check for this but actually, looking at it now, it's
has some stupid stuff going on.  I will fix it up a bit.  But then you
still have to build the cross function DB which takes overnight on my
system.  I run Smatch on linux-next every day and I would have caught
this bug.

There are also people running Coccinelle scripts which do the same
thing.  If I didn't catch it they would have.

What I would like is an annotation in the comments that a Perl script
could parse:

Returns: Error pointers or valid pointer
Returns: Error pointers, NULL or valid pointer
Returns: Negative error codes or zero
Returns: -EINVAL, 0, 1

Smatch or Coccinelle could easily use this.

Btw, I have attached the Smatch warnings for this check.  It's almost
all dead code related to debugfs.  The correct thing there is just to
delete all the checking.

There are a couple false positives related to functions which return
both error pointers and NULL depending on the .config.

regards,
dan carpenter


--mLVOHNju7DtbO5jx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

drivers/mtd/ubi/debug.c:228 ubi_debugfs_init() warn: 'dfs_rootdir' is an error pointer or valid
drivers/i2c/busses/i2c-imx.c:1392 i2c_imx_init_recovery_info() warn: 'i2c_imx->pinctrl' is an error pointer or valid
drivers/i2c/busses/i2c-at91-master.c:835 at91_init_twi_recovery_gpio() warn: 'rinfo->pinctrl' is an error pointer or valid
drivers/i2c/busses/i2c-gpio.c:268 i2c_gpio_fault_injector_init() warn: 'i2c_gpio_debug_dir' is an error pointer or valid
drivers/i2c/busses/i2c-gpio.c:273 i2c_gpio_fault_injector_init() warn: 'priv->debug_dir' is an error pointer or valid
drivers/hwmon/pmbus/adm1266.c:343 adm1266_init_debugfs() warn: 'data->debugfs_dir' is an error pointer or valid
drivers/hwmon/pmbus/ucd9000.c:515 ucd9000_init_debugfs() warn: 'data->debugfs' is an error pointer or valid
drivers/iommu/tegra-smmu.c:1059 tegra_smmu_debugfs_init() warn: 'smmu->debugfs' is an error pointer or valid
drivers/infiniband/hw/mlx4/srq.c:213 mlx4_ib_create_srq() warn: 'srq->umem' is an error pointer or valid
drivers/block/nbd.c:1669 nbd_dev_dbg_init() warn: 'dir' is an error pointer or valid
drivers/block/nbd.c:1695 nbd_dbg_init() warn: 'dbg_dir' is an error pointer or valid
drivers/block/pktcdvd.c:454 pkt_debugfs_dev_new() warn: 'pd->dfs_d_root' is an error pointer or valid
drivers/ntb/test/ntb_tool.c:1498 tool_setup_dbgfs() warn: 'tc->dbgfs_dir' is an error pointer or valid
drivers/ntb/test/ntb_perf.c:1358 perf_setup_dbgfs() warn: 'perf->dbgfs_dir' is an error pointer or valid
drivers/thermal/mediatek/lvts_thermal.c:191 lvts_debugfs_init() warn: 'lvts_td->dom_dentry' is an error pointer or valid
drivers/thermal/mediatek/lvts_thermal.c:200 lvts_debugfs_init() warn: 'dentry' is an error pointer or valid
drivers/spi/spi-dw-core.c:66 dw_spi_debugfs_init() warn: 'dws->debugfs' is an error pointer or valid
drivers/spi/spi-hisi-kunpeng.c:172 hisi_spi_debugfs_init() warn: 'hs->debugfs' is an error pointer or valid
drivers/gpu/drm/imx/lcdc/imx-lcdc.c:403 imx_lcdc_probe() warn: 'lcdc' is an error pointer or valid
drivers/nvme/host/fault_inject.c:30 nvme_fault_inject_init() warn: 'parent' is an error pointer or valid
drivers/regulator/core.c:5259 rdev_init_debugfs() warn: 'rdev->debugfs' is an error pointer or valid
drivers/regulator/core.c:6181 regulator_init() warn: 'debugfs_root' is an error pointer or valid
drivers/media/v4l2-core/v4l2-fwnode.c:1241 v4l2_fwnode_reference_parse_int_props() warn: 'fwnode' is an error pointer or valid
drivers/scsi/mpt3sas/mpt3sas_debugfs.c:102 mpt3sas_init_debugfs() warn: 'mpt3sas_debugfs_root' is an error pointer or valid
drivers/scsi/mpt3sas/mpt3sas_debugfs.c:127 mpt3sas_setup_debugfs() warn: 'ioc->debugfs_root' is an error pointer or valid
drivers/scsi/qla2xxx/qla_dfs.c:119 qla2x00_dfs_create_rport() warn: 'fp->dfs_rport_dir' is an error pointer or valid
drivers/scsi/qla2xxx/qla_dfs.c:708 qla2x00_dfs_setup() warn: 'vha->dfs_rport_root' is an error pointer or valid
drivers/scsi/megaraid/megaraid_sas_debugfs.c:105 megasas_init_debugfs() warn: 'megasas_debugfs_root' is an error pointer or valid
drivers/scsi/megaraid/megaraid_sas_debugfs.c:135 megasas_setup_debugfs() warn: 'instance->debugfs_root' is an error pointer or valid
drivers/nfc/nfcsim.c:340 nfcsim_debugfs_init() warn: 'nfcsim_debugfs_root' is an error pointer or valid
drivers/net/wireless/ath/ath5k/debug.c:985 ath5k_debug_init_device() warn: 'phydir' is an error pointer or valid
drivers/net/wireless/ath/ath9k/htc_drv_debug.c:494 ath9k_htc_init_debug() warn: 'priv->debug.debugfs_phy' is an error pointer or valid
drivers/net/wireless/ath/ath9k/debug.c:1423 ath9k_init_debug() warn: 'sc->debug.debugfs_phy' is an error pointer or valid
drivers/net/wireless/ath/ath6kl/debug.c:1796 ath6kl_debug_init_fs() warn: 'ar->debugfs_phy' is an error pointer or valid
drivers/net/wireless/marvell/mwifiex/debugfs.c:962 mwifiex_dev_debugfs_init() warn: 'priv->dfs_dev_dir' is an error pointer or valid
drivers/net/wireless/mediatek/mt76/debugfs.c:112 mt76_register_debugfs_fops() warn: 'dir' is an error pointer or valid
drivers/net/wireless/mediatek/mt7601u/debugfs.c:130 mt7601u_init_debugfs() warn: 'dir' is an error pointer or valid
drivers/net/ethernet/brocade/bna/bnad_debugfs.c:503 bnad_debugfs_init() warn: 'bna_debugfs_root' is an error pointer or valid
drivers/net/ethernet/brocade/bna/bnad_debugfs.c:515 bnad_debugfs_init() warn: 'bnad->port_debugfs_root' is an error pointer or valid
drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c:338 otx2_ptp_init() warn: 'ptp_ptr->ptp_clock' is an error pointer or valid
drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c:596 mvpp2_dbgfs_c2_entry_init() warn: 'c2_entry_dir' is an error pointer or valid
drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c:629 mvpp2_dbgfs_flow_tbl_entry_init() warn: 'flow_tbl_entry_dir' is an error pointer or valid
drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c:649 mvpp2_dbgfs_cls_init() warn: 'cls_dir' is an error pointer or valid
drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c:653 mvpp2_dbgfs_cls_init() warn: 'c2_dir' is an error pointer or valid
drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c:663 mvpp2_dbgfs_cls_init() warn: 'flow_tbl_dir' is an error pointer or valid
drivers/net/ethernet/marvell/sky2.c:4532 sky2_debug_init() warn: 'ent' is an error pointer or valid
drivers/net/ethernet/ti/am65-cpts.c:1154 am65_cpts_create() warn: 'cpts->ptp_clock' is an error pointer or valid
drivers/net/ethernet/davicom/dm9000.c:1578 dm9000_probe() warn: 'pdata' is an error pointer or valid
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1842 i40e_dbg_init() warn: 'i40e_dbg_root' is an error pointer or valid
drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:708 hns_mac_register_phydev() warn: 'phy' is an error pointer or valid
drivers/net/mdio/mdio-xgene.c:268 xgene_enet_phy_register() warn: 'phy_dev' is an error pointer or valid
drivers/mailbox/mailbox-test.c:262 mbox_test_add_debugfs() warn: 'tdev->root_debugfs_dir' is an error pointer or valid
drivers/android/binder.c:6548 binder_init() warn: 'binder_debugfs_dir_entry_root' is an error pointer or valid
security/apparmor/domain.c:1184 aa_change_hat() warn: 'new' is an error pointer or valid
security/integrity/evm/evm_secfs.c:318 evm_init_secfs() warn: 'evm_symlink' is an error pointer or valid
fs/nfs/dir.c:451 nfs_readdir_folio_get_next() warn: 'folio' is an error pointer or valid
fs/nfsd/nfs4proc.c:377 nfsd4_create_file() warn: 'child' is an error pointer or valid
fs/nfsd/nfs3proc.c:347 nfsd3_create_file() warn: 'child' is an error pointer or valid
fs/pstore/zone.c:1222 psz_init_zones() warn: 'zone' is an error pointer or valid
kernel/locking/lock_events.c:149 init_lockevent_counts() warn: 'd_counts' is an error pointer or valid
lib/test_hmm.c:559 dmirror_allocate_chunk() warn: 'ptr' is an error pointer or valid
lib/notifier-error-inject.c:86 err_inject_init() warn: 'notifier_err_inject_dir' is an error pointer or valid
lib/error-inject.c:220 ei_debugfs_init() warn: 'dir' is an error pointer or valid
mm/frontswap.c:266 init_frontswap() warn: 'root' is an error pointer or valid
mm/shrinker_debug.c:133 shrinker_debugfs_scan_write() warn: 'memcg' is an error pointer or valid
mm/filemap.c:3381 filemap_fault() warn: 'folio' is an error pointer or valid

--mLVOHNju7DtbO5jx--
