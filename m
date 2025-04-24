Return-Path: <linux-ext4+bounces-7452-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CB2A9AD76
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA317B26C0
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62E2750EE;
	Thu, 24 Apr 2025 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="x9hoW6VH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rxWR7H/0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884E274FFB;
	Thu, 24 Apr 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497888; cv=none; b=I2PSGkZMk3OkwW7qcYbw2iPR8MeDfzZP6zouCfQUJ59UWwGX4KoXbiesAKwHmDbRMa60GEfRS9ziNp1/iRRul8hB5bPNdYUkVqLxoaJR2cnyNGeZBK/xuDcmCRDCIPffqHUioss7iWFjTX5U3KWl7zn+J78BJbJlqAtgef/kPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497888; c=relaxed/simple;
	bh=b4h14PjB5eCL+QmyIjGEQjAlWIwFpKJFvYfu2kYALJg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ENyLAUC2oqcM97psJiDSDEYMh0gzJqvxUOGfwJidszSdcwlrjV9WyCAtb5ocGEsN6Y4crXm8RTXnFOSYmye1AArJVZXBILeH0Z8LZXksXw+hBE8hKwYw/WLzeuPBNyruBNRMpcmv5m4yBfe+RabQ70wS8LDkrywwgoxN5Z5BzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=x9hoW6VH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rxWR7H/0; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 124AB254017D;
	Thu, 24 Apr 2025 08:31:25 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Thu, 24 Apr 2025 08:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745497884;
	 x=1745584284; bh=RtdNYQprCkTfO53+K34TklVUk+g8KRs38puDUMxkOE0=; b=
	x9hoW6VHJGvuyAnxMX42C44HrmqwshWX8HWQLT85i9zURkWIBIbTHNj1MEvYsed+
	C1pW2byytIpU9QBq3WUD/3epJKlZjrtr0iO9cphjEJXBWWVmGG/4mWyksjqR1Lc0
	fJI6TbA1ApZ7fEn3cpL5Yd2mVNM+O1A3OwSeO+8auW5gfFgvOx+RFMfH9sxhZiW5
	9W6v94P0xGzrJKO+L+PPNm+BdxruTrs2LZ9hAqau3G2KAKE8l+5cjXR2UgHFDbEw
	9ggkqc2PGfP3B4a9X6Yl1LGntVgEEIBiZbcmFDdK3jIjuX9GnVznBNjB5CmWIbEG
	vYJsM2HYQzdV2zVAsDCpZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745497884; x=
	1745584284; bh=RtdNYQprCkTfO53+K34TklVUk+g8KRs38puDUMxkOE0=; b=r
	xWR7H/0LQ5UhKdEOnvWv1KvRMCfY4pdQxWZu4JummeoMcWSe2plesFul+2CuOKDE
	i8nd04gN9tFqdFNptCRb8W4u5/V1Kag7Z36C4VlnIwviGQim2fEmQ2k+cFGGsLzT
	N4IevvNsjKnEiNjpXttiC+OX8p03pYtWid9GI88k1Dvm9pTUtrsfOlb1er8uaHGO
	yGiDAgtMM5Ni7qba2cFhcsL7mHxDlB/Aeh5W/uhKf3VmY+A7YlMMJtjBgmYOmrlv
	Wn2/2msQOp5FgmY7VrZeWGA10TLS0bz8tAha4Kj5cjyjqRGjL44rD0uCChaV3hkl
	qSz7nYf5eTwKYCbfpPWFA==
X-ME-Sender: <xms:Gy8KaOrDzLr9y1iJDslTqnCBkNGbLnug2uREADpsc94sDaGNLquZfA>
    <xme:Gy8KaMrC4VAsnTj4owygcZlj0YSqvy0f7IjjuKYGZIHK8QU1kilGMccda7S0AalaQ
    x3kd-EbRaB9gLj4SU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrughilhhgvghrrdhkvghrnh
    gvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehrihhtvghshhdrlhhishhtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpth
    htoheplhhisggrohhkuhhnudeshhhurgifvghirdgtohhmpdhrtghpthhtohephihirdii
    hhgrnhhgsehhuhgrfigvihdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihhrghnghhshh
    hiuggrsehkhihlihhnohhsrdgtnh
X-ME-Proxy: <xmx:Gy8KaDPEufo5wQdMaUZXqpsyiQB-0OR0YvPR8PpjqGKaG3WQ4sV54g>
    <xmx:Gy8KaN7HRQUPoxvc-DQNdmePQCknRP0zQOJZkuUC8LpNW7-xrkO_bw>
    <xmx:Gy8KaN5RM_FFamP1eIx4O4yiKrKYD1kDlgMEQQBpfjSr9XyR3QTeNw>
    <xmx:Gy8KaNjr9UtjbkFz3aiw2viU6hBWBNZC-WaLrwpXg9slpx18XlK3vA>
    <xmx:HC8KaHMV0z8-GYzwLdcsQeRKRV_-lRHj7fiWPyWT9SkXv2FCdGSRWDkB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4EDD32220073; Thu, 24 Apr 2025 08:31:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T141ec88331dc5a96
Date: Thu, 24 Apr 2025 14:31:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jan Kara" <jack@suse.cz>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>,
 "Zhang Yi" <yi.zhang@huawei.com>, "Ojaswin Mujoo" <ojaswin@linux.ibm.com>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Shida Zhang" <zhangshida@kylinos.cn>, "Baokun Li" <libaokun1@huawei.com>,
 "Jann Horn" <jannh@google.com>, "Brian Foster" <bfoster@redhat.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <b8aab0e1-dd32-4c03-8123-a0df5238558a@app.fastmail.com>
In-Reply-To: 
 <6vjo6wo5c5tadvhnrvo2affcqu2cf6ecrx4ol5jxl6mvz7vu3z@6wgvyptlpq4p>
References: <20250423164354.2780635-1-arnd@kernel.org>
 <6vjo6wo5c5tadvhnrvo2affcqu2cf6ecrx4ol5jxl6mvz7vu3z@6wgvyptlpq4p>
Subject: Re: [PATCH] ext4: avoid -Wformat-security warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Apr 24, 2025, at 13:39, Jan Kara wrote:
> On Wed 23-04-25 18:43:49, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> check_igot_inode() prints a variable string, which causes a harmless
>> warning with 'make W=1':
>> 
>> fs/ext4/inode.c:4763:45: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>>  4763 |         ext4_error_inode(inode, function, line, 0, err_str);
>> 
>> Use a trivial "%s" format string instead.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Frankly I don't care much either way but if my memory serves me well year
> or two ago someone was going through the kernel and was replacing pointless
> ("%s", str) cases with printing the string directly. So we should make up
> our minds how we want this... In my opinion this is one of the warnings
> which may be useful but have false positives too often (like here where
> err_str is just a selection from several string literals) so I'm not sure
> it's worth the effort to try to silence it.

I had a look at the git log now and see no evidence of those
patches getting merged, but plenty of patches going the same way
as my patch.

I found one patch that removes a "%s" in the last decade
in favor of directly using a string variable, but it's
part of a larger rework and seems to have been inadvertent
rather than as a directed change:

60a883d119ab ("spi: use kthread_create_worker() helper")

I have patches for all remaining -Wformat-security warnings, in
117 files. I have not tried to split that up and add individual
changelog texts but instead just send patches for regressions
at the moment.

      Arnd

8<---
# full list of files with warnings

arch/x86/kernel/cpu/mce/core.c
arch/x86/kernel/e820.c
arch/x86/xen/smp_pv.c
drivers/accel/habanalabs/common/device.c
drivers/accel/habanalabs/gaudi/gaudi.c
drivers/block/aoe/aoechr.c
drivers/bus/ti-sysc.c
drivers/cdrom/cdrom.c
drivers/char/mem.c
drivers/devfreq/sun8i-a33-mbus.c
drivers/dma-buf/dma-heap.c
drivers/firmware/arm_scmi/notify.c
drivers/firmware/arm_scmi/transports/virtio.c
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
drivers/gpu/drm/amd/amdkfd/kfd_process.c
drivers/gpu/drm/arm/display/komeda/komeda_event.c
drivers/gpu/drm/etnaviv/etnaviv_gpu.c
drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
drivers/gpu/drm/tests/drm_plane_helper_test.c
drivers/gpu/drm/vc4/vc4_crtc.c
drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
drivers/i3c/master.c
drivers/iio/adc/aspeed_adc.c
drivers/iio/industrialio-core.c
drivers/iio/trigger/iio-trig-loop.c
drivers/infiniband/core/device.c
drivers/infiniband/hw/hfi1/device.c
drivers/infiniband/hw/hfi1/msix.c
drivers/infiniband/hw/mlx4/mcg.c
drivers/infiniband/hw/qib/qib_file_ops.c
drivers/infiniband/ulp/rtrs/rtrs-clt.c
drivers/input/tablet/aiptek.c
drivers/iommu/arm/arm-smmu/qcom_iommu.c
drivers/iommu/exynos-iommu.c
drivers/iommu/irq_remapping.c
drivers/iommu/mtk_iommu_v1.c
drivers/iommu/omap-iommu.c
drivers/iommu/sprd-iommu.c
drivers/iommu/sun50i-iommu.c
drivers/iommu/tegra-smmu.c
drivers/md/dm-raid.c
drivers/media/dvb-core/dvbdev.c
drivers/media/pci/cx23885/cx23885-dvb.c
drivers/media/pci/netup_unidvb/netup_unidvb_core.c
drivers/media/pci/saa7164/saa7164-dvb.c
drivers/media/pci/smipcie/smipcie-main.c
drivers/media/pci/zoran/zoran_card.c
drivers/media/test-drivers/visl/visl-dec.c
drivers/media/usb/dvb-usb-v2/rtl28xxu.c
drivers/media/usb/dvb-usb/dib0700_devices.c
drivers/media/usb/pvrusb2/pvrusb2-hdw.c
drivers/media/usb/pvrusb2/pvrusb2-std.c
drivers/media/v4l2-core/v4l2-spi.c
drivers/mtd/mtdcore.c
drivers/net/dsa/hirschmann/hellcreek_ptp.c
drivers/net/dsa/sja1105/sja1105_spi.c
drivers/net/ethernet/netronome/nfp/devlink_param.c
drivers/net/ethernet/netronome/nfp/nfp_main.c
drivers/net/ieee802154/adf7242.c
drivers/net/wireless/intel/ipw2x00/libipw_wx.c
drivers/nvme/host/sysfs.c
drivers/of/module.c
drivers/perf/arm_cspmu/arm_cspmu.c
drivers/platform/mellanox/mlxbf-pmc.c
drivers/platform/mellanox/mlxreg-hotplug.c
drivers/platform/mellanox/mlxreg-io.c
drivers/platform/x86/intel/int3472/clk_and_regulator.c
drivers/platform/x86/intel/int3472/discrete.c
drivers/platform/x86/siemens/simatic-ipc.c
drivers/platform/x86/x86-android-tablets/core.c
drivers/pnp/interface.c
drivers/power/supply/ds2760_battery.c
drivers/pwm/core.c
drivers/regulator/da9121-regulator.c
drivers/remoteproc/remoteproc_core.c
drivers/scsi/lpfc/lpfc_scsi.c
drivers/scsi/lpfc/lpfc_sli.c
drivers/scsi/qla2xxx/qla_init.c
drivers/soc/qcom/qcom_aoss.c
drivers/spi/spi-lantiq-ssc.c
drivers/spi/spi.c
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
drivers/target/iscsi/iscsi_target_configfs.c
drivers/tty/serial/pch_uart.c
drivers/usb/phy/phy.c
drivers/usb/typec/tcpm/tcpm.c
fs/nfs/nfs42xattr.c
fs/ocfs2/dlm/dlmdomain.c
fs/quota/dquot.c
fs/xfs/xfs_buf_item_recover.c
include/linux/kernel.h
kernel/power/suspend_test.c
kernel/rcu/tree.c
kernel/trace/preemptirq_delay_test.c
kernel/trace/rv/reactor_panic.c
kernel/trace/rv/reactor_printk.c
lib/kunit/string-stream.c
lib/tests/scanf_kunit.c
mm/backing-dev.c
net/core/filter.c
net/rds/transport.c
net/tipc/netlink_compat.c
scripts/Makefile.extrawarn
sound/core/control.c
sound/core/control_led.c
sound/core/seq/seq_clientmgr.c
sound/core/seq/seq_ump_client.c
sound/core/sound.c
sound/drivers/opl3/opl3_seq.c
sound/pci/hda/hda_bind.c
sound/pci/korg1212/korg1212.c
sound/pci/rme32.c
sound/pci/rme96.c
sound/soc/fsl/imx-pcm-rpmsg.c
sound/soc/sof/intel/hda-codec.c
sound/usb/mixer_quirks.c

